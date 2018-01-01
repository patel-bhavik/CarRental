require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Signup' do
    it 'renders new page' do
      get :new
      expect(response).to render_template('new')
    end

    it 'renders signup page on invalid signup with blank password' do
      post :create, params: { user: {email: 'foo@bar.com', first_name: 'foo', last_name: 'bar', password: '' } }
      user = assigns(:user)

      expect(response).to render_template('new')
      expect(user.errors.any?).to be true
    end

    it 'renders signup page on invalid signup with blank email' do
      post :create, params: { user: {email: '', first_name: 'foo', last_name: 'bar', password: 'foobar' } }
      user = assigns(:user)

      expect(response).to render_template('new')
      expect(user.errors.any?).to be true
    end

    it 'renders signup page on invalid signup with blank first name' do
      post :create, params: { user: {email: 'foo@bar.com', first_name: '', last_name: 'bar', password: 'foobar' } }
      user = assigns(:user)

      expect(response).to render_template('new')
      expect(user.errors.any?).to be true
    end

    it 'renders signup page on invalid signup with blank last name' do
      post :create, params: { user: {email: 'foo@bar.com', first_name: 'foo', last_name: '', password: 'foobar' } }
      user = assigns(:user)

      expect(response).to render_template('new')
      expect(user.errors.any?).to be true
    end

    it 'renders home page on valid signup with correct arguments' do
      create(:user)
      post :create, params: { user: {email: 'foo@bar.com', first_name: 'foo', last_name: 'bar', password: 'foobar' } }

      expect(response).to redirect_to root_path
    end
  end

  describe 'Show' do
    it 'should render show' do
      user = create(:user)
      session[:user_id] = user.id
      get :show, params: { id: user.id }
      expect(response).to render_template('show')
    end
  end

  describe 'Edit profile' do
    user = nil
    before(:each) do
      user = create(:user)
      session[:user_id] = user.id
    end

    it 'should render edit' do
      get :edit, params: { id: user.id }
      expect(response).to render_template('edit')
    end

    it 'renders edit page on invalid edit with blank password' do
      patch :update, params: { id: user.id, user: {email: 'foo@bar.com', first_name: 'foo', last_name: 'bar', password: '' } }
      user = assigns(:user)

      expect(response).to render_template('edit')
      expect(user.errors.any?).to be true
    end

    it 'renders edit page on invalid edit with blank email' do
      patch :update, params: { id: user.id, user: {email: '', first_name: 'foo', last_name: 'bar', password: 'foobar' } }
      user = assigns(:user)

      expect(response).to render_template('edit')
      expect(user.errors.any?).to be true
    end

    it 'renders edit page on invalid edit with blank first_name' do
      patch :update, params: { id: user.id, user: {email: 'foo@bar.com', first_name: '', last_name: 'bar', password: 'foobar' } }
      user = assigns(:user)

      expect(response).to render_template('edit')
      expect(user.errors.any?).to be true
    end

    it 'renders edit page on invalid edit with blank last_name' do
      patch :update, params: { id: user.id, user: {email: 'foo@bar.com', first_name: 'foo', last_name: '', password: 'foobar' } }
      user = assigns(:user)

      expect(response).to render_template('edit')
      expect(user.errors.any?).to be true
    end

    it 'renders home page on valid signup with correct arguments' do
      patch :update, params: { id: user.id, user: {email: 'foo@bar.com', first_name: 'foo', last_name: 'bar', password: 'foobar' } }

      expect(response).to redirect_to user
    end
  end
end
