class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
  
    if params[:tag].present?
      @books = @books.where("tags LIKE ?", "%#{params[:tag]}%")
    end
  
    case params[:sort]
    when "new"
      @books = @books.order(created_at: :desc)
    when "rating"
      @books = Book.order(Arel.sql("COALESCE(CAST(books.star AS FLOAT), 0) DESC NULLS LAST"))
    end
  
    @book = Book.new
  end
  
  
  

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def tag_search
    @tag = params[:tag]
    @books = Book.where("tags LIKE ?", "%#{@tag}%").where.not(id: nil)  # 無効なデータを除外
    @books = @books.reject { |book| book.id.nil? }  # book_id が nil のデータを完全にフィルタリング
    @book = Book.new  # フォーム用の空オブジェクト
    render "search_book"
  end
  
  
  
  
  

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :tags)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end

