require 'rails_helper'
require 'byebug'

RSpec.describe 'Get with authentication and unauthenticacion ', type: :request do #test de integracion
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:user_tags) { create_list(:tag, 2 ,user_id: user.id) }
  let!(:other_user_tags) { create_list(:tag,2, user_id: other_user.id) }
  let!(:user_tasks) { create_list(:task, 10 , user_id: user.id) } # en factory task ya asignamos las etiquetas (labelleds model)
  let!(:other_user_tasks) { create_list(:task, 10, user_id: other_user.id) }

 before :each do #que se registre el primer usuario antes de cada prueba
    sign_in user
  end

  ## recordar que en la variable @tasks del controlador, almacenamos las tareas que estan por completar y en @tasks_completed las tareas ya completadas
# y en @task_all todas las tareas que cumple con los filtros task_controller.rb :18
  describe 'GET /task?params[/tasks] 'do
    context 'With authentication valid.'do
      context 'When requisting user tasks .'do
        before { get "/tasks/"  }
        it 'should return only task of user logged' do
          @tareas = assigns(:tasks) #esto me devulve el html del index tasks
          @tareas.each do |tarea|
            p tarea
            expect(tarea.user_id).to eq(user.id)
          end
        end
      end
      before { get "/tasks/", params:{ "/tasks"=>{"start_date"=>"2022-04-07"}  } }
      #pay load
      it 'should return only task that start_date is later  o same than today' do
        @tareas = assigns(:tasks_all) #esto me devulve el html del index tasks
        @tareas.each do |tarea|
          expect(tarea.start_date).to be >= Time.zone.now
        end
      end
      before { get "/tasks/", params:{ "/tasks"=>{"end_date"=>"2022-05-09"}  } }
      it 'should return only tasks that end_date is earlier  o same than today' do
        @tareas = assigns(:tasks_all) #esto me devulve el html del index tasks
        @tareas.each do |tarea|
          expect(tarea.end_date).to be >= Time.zone.now
        end
      end
      before { get "/tasks/", params:{ "/tasks"=>{"importance"=> 3}  } }
      it 'should return only tasks that than importance is 3' do
        @tareas = assigns(:tasks_all) #esto me devulve el html del index tasks
        @tareas.each do |tarea|
          expect(tarea.importance).to eq(3)
        end
      end
    end
  end


end
