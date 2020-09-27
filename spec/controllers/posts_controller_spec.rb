require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "#index" do

    context "ログインしているユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to be_successful
      end
  
      it "200のレスポンスを返すこと" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do

      it "正常にレスポンスを返すこと" do
        get :index
        expect(response).to be_successful
      end
  
      it "200のレスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#show" do

    context "ログインしているユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      it "正常にレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response).to be_successful
      end 

      it "200のレスポンスを返すこと" do
        sign_in @user
        get :show, params: { id: @post.id }
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do

      before do
        @post = FactoryBot.create(:post)
      end

      it "302のレスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        get :show, params: { id: @post.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do

    context "ログインしているユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "投稿を作成できること" do
        post_params = FactoryBot.attributes_for(:post) 
        sign_in @user
        expect { post :create, params: { post: post_params }}.to change(@user.posts, :count).by(1)
      end
    end

    context "ログインしていないユーザーとして" do
      
      it "302のレスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        post_params = FactoryBot.attributes_for(:post)
        post :create, params: { post: post_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe "#update" do

    context "ログインしているユーザーとして" do
      
      before do
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: @user, impression: "美味しかったです")
      end

      it "投稿を更新できること" do
        post_params = FactoryBot.attributes_for(:post, impression: "とても美味しかったです")
        sign_in @user
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.impression).to eq "とても美味しかったです"
      end 
    end

    context "ポストの投稿者ではないログインユーザーとして" do

      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post, user: other_user, impression: "美味しかったです")
      end

      it "投稿を更新できないこと" do
        post_params = FactoryBot.attributes_for(:post, impression: "とても美味しかったです")
        sign_in @user
        patch :update, params: { id: @post.id, post: post_params }
        expect(@post.reload.impression).to eq "美味しかったです"
      end

      it "投稿一覧ページへリダイレクトすること" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to root_path
      end 
    end
    context "ログインしていないユーザーとして" do
      
      before do
        @post = FactoryBot.create(:post)
      end

      it "302のレスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトすること" do
        post_params = FactoryBot.attributes_for(:post)
        patch :update, params: { id: @post.id, post: post_params }
        expect(response).to redirect_to new_user_session_path
      end 
    end
  end
end