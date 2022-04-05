require 'rails_helper'
require 'byebug'

RSpec.describe 'Get with authentication and unauthenticacion ', type: :request do #test de integracion
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:user_tags) { create_list(:tag, 2 ,user_id: user.id) }
  let!(:other_user_tags) { create_list(:tag,2, user_id: other_user.id) }
  let!(:user_tasks) { create_list(:task, 3 , user_id: user.id) } # en factory task ya asignamos las etiquetas labelleds
  let!(:other_user_tasks) { create_list(:task, 3 , user_id: other_user.id) }

 before :each do #que se registre el primer usuario antes de cada prueba
    sign_in user
  end



  describe 'GET /task?params[/tasks] 'do
    context 'With authentication valid.'do
      context 'When requisting other user tasks .'do
      before { get "/tasks/", params: { session: { email: user.email, password: user.password } }  }
      #pay load
      it 'should return only task of user' do
          puts response.body
        end

      end

    end
  end
end
