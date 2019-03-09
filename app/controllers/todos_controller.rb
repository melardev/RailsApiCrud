class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    dto = get_todo_list_dto Todo
    render json: dto, status: :ok
  end

  def get_pending
    todos = get_todo_list_dto Todo.where(completed: false)
    render json: todos, status: :ok
  end

  def get_completed
    dto = get_todo_list_dto Todo.where(completed: true)
    render json: dto, status: :ok
  end

  # GET /todos/1
  def show
    render json: @todo, status: :ok
  end

  # POST /todos
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      dto = ErrorResponseDto.new 'Something went wrong'
      render json: dto, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo, status: :ok
    else
      dto = ErrorResponseDto.new 'Something went wrong'
      render json: dto, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    render json: nil, status: :no_content
  end

  def destroy_all
    # delete_all vs destroy_all? delete skips callbacks, destroy does execute them
    # destroy deletes the object and associated objects(not used in this project)
    # delete will only delete the current object,no the associated models
    Todo.destroy_all
    render json: nil, status: :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def get_todo_list_dto(query)
    query.order(created_at: :desc).select("id, title, completed, created_at, updated_at")
  end


  # Only allow a trusted parameter "white list" through.
  def todo_params
    params.permit(:title, :description, :completed)
  end
end
