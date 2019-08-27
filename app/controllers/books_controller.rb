class BooksController < ApplicationController
	before_action :authenticate_user!

	def index
		 @books = Book.all
		 @new_book = Book.new
	end
	def show
		 @book = Book.find(params[:id])
		 @new_book = Book.new
		 @books = Book.all
		 @user = current_user
	end

	def create
		 @new_book = Book.new(book_params)
		 @new_book.user_id = current_user.id
         if @new_book.save
         	flash[:notice] = "You have creatad book successfully."
            redirect_to book_path(@new_book.id), notice: "You have creatad book successfully."
        else
         @books = Book.all
         render :index
        end
	end

	# bookers1を参考に
	def edit
		 @book = Book.find(params[:id])
		 if @book.user.id != current_user.id
		 	#p "呼び出された！！！！！"
         redirect_to books_path
		 end
		    #p "呼び出されてない！！！！！"
	end

	def update
		 @book = Book.find(params[:id])
         if @book.update(book_params)
         	flash[:notice] = "You have creatad book successfully."
            redirect_to book_path(@book.id), notice: "You have creatad book successfully."
        else
         @books = Book.all
         render :edit

		 #if @book.user.id
		 #@book.update(book_params)
		 #redirect_to book_path(@book)
		end
	end

	def destroy
         @book = Book.find(params[:id])
         @book.destroy
         redirect_to books_path
	end

	private
         def book_params
         params.require(:book).permit(:title, :body)
  end
end