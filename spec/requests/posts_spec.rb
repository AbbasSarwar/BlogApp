require 'rails_helper'

RSpec.describe 'Routing Requests', type: :request do
  describe 'Status & Rendering & correct placeholder for Posts' do
    it 'Status User Posts users/:id/posts' do
        get '/users/56/posts'
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response.body).to include('User posts')
      end
  
      it 'Status A Post of User users/:id/posts/:id' do
        get '/users/56/posts/1'
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(response.body).to include('USER: Post found by ID')
      end
    end
end
  