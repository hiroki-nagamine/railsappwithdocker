class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]

 def index
   @boards = Board.page(params[:page])
 end

 def show
 end

 def new
   @board = Board.new
 end

 def create
   board = Board.new(borad_params)
   if Board.save
     flash[:notice] = "#{board.title}の掲示板を変更しました"
     redirect_to board
   else
     redirect_to new_board_path, flash: {
       error_message: board.errors.full_message
     }
   end
 end

 def update
  @board.update(board_params)
   redirect_to board
 end

 def destroy
   @board.delete
   redirect_to boards_path,flash: { notice: "#{@board.title}の掲示板が削除されました"}
 end

 private

 def board_params
   params.require(:board).permit(:name, :title, :body)
 end

 def set_target_board
   @board = Board.find(params[:id])
 end
end
