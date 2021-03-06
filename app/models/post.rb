class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comment, dependent: :destroy
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :store, presence: true, length: { maximum: 16 }
  validates :prefecture, presence: { message: 'を選択してください' }
  validates :genre, presence: { message: 'を選択してください' }
  validates :ramen, presence: true, length: { maximum: 16 }
  validates :impression, presence: true, length: { maximum: 110 }
  validates :image, presence: { message: 'をアップロードしてください' }
  mount_uploader :image, ImageUploader
  include JpPrefecture

  enum prefecture: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6,
    福島県: 7, 茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12,
    東京都: 13, 神奈川県: 14, 新潟県: 15, 富山県: 16, 石川県: 17,
    福井県: 18, 山梨県: 19, 長野県: 20, 岐阜県: 21, 静岡県: 22, 愛知県: 23,
    三重県: 24, 滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29,
    和歌山県: 30, 鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34,
    山口県: 35, 徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39, 福岡県: 40,
    佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45,
    鹿児島県: 46, 沖縄県: 47
  }

  enum genre: {
    醤油: 1, 味噌: 2, 塩: 3, 豚骨: 4, 坦々麺: 5, 辛麺: 6, つけ麺: 7, 油そば: 8
  }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(
      ["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like']
    )

    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: "like"
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
