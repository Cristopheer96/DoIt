require 'rails_helper'
require 'byebug'

RSpec.describe 'Get with authentication and unauthenticacion ', type: :request #test de integracion
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:user_tags) { create_list(:tags 10,user_id: user.id) }
  let!(:other_user_tags) { create_list(:tag, user_id: other_user.id) }
  let!(:user_tasks) { create_list(:task, user_id: user.id) } # en factory task ya asignamos las etiquetas labelleds
  let!(:user_tasks) { create_list(:task, user_id: user.id) }

    #request con authenticatin en http hay un header adicional donde se espepcifica el token
  # asi esl header para enviar token de autorizacion  => "Authorization: Bearer xxxx"




  describe 'GET /task?params[/tasks] 'do
    context 'With authentication valid.'do
      context 'When requisting other taks user .'do
        context 'When post is public.'do
          before { get "/posts/#{other_user_post.id}", headers: auth_headers }
          #pay load
          context 'Pay load.' do
            subject { payload }
            it { is_expected.to include(:id)}
          end
          context 'Response.' do
            subject { response}
            it { is_expected.to have_http_status(:ok)}
          end
          #reponse
        end
        context 'When post is not public.' do
          before { get "/posts/#{other_user_post_draft.id}", headers: auth_headers }
          #pay load
          context 'Pay load.' do
            subject { payload }
            it { is_expected.to include(:error)}
          end
          context 'Response' do
            subject { response }
            it { is_expected.to have_http_status(:not_found) }
          end
        end
      end
      context 'When requisiting user post'do
      end
    end
  end



end
