class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter_id = current_user.id

    begin
      Article.transaction do
        @version = @article.create_version!(params[:version], current_user)
      end
    rescue ActiveRecord::RecordNotSaved,
           ActiveRecord::RecordInvalid
      render action: :index and return false
    end
    redirect_to article_path(@article)
  end
end

# creating version and setting the writer moved here

class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter_id = current_user.id
    @version = @article.versions.build(params[:version])
    @version.writer_id = current_user.id

    begin
      Article.transaction do
        @version = @article.create_version!(params[:version], current_user)
      end
    rescue ActiveRecord::RecordNotSaved,
           ActiveRecord::RecordInvalid
      render action: :index and return false
    end
    redirect_to article_path(@article)
  end
end

# refactoring

class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter_id = current_user.id
    @version = @article.versions.build(params[:version])
    @version.writer_id = current_user.id

    begin
      Article.transaction do
        @article.save!
      end
    rescue ActiveRecord::RecordNotSaved,
           ActiveRecord::RecordInvalid
      render action: :index and return false
    end
    redirect_to article_path(@article)
  end
end

# transaction not usefull anymore

class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter_id = current_user.id
    @version = @article.versions.build(params[:version])
    @version.writer_id = current_user.id

    begin
      @article.save!
    rescue ActiveRecord::RecordNotSaved,
           ActiveRecord::RecordInvalid
      render action: :index and return false
    end
    redirect_to article_path(@article)
  end
end

# refactoring

class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter_id = current_user.id
    @version = @article.versions.build(params[:version])
    @version.writer_id = current_user.id

    if @article.save
      render action: :index
    else
      redirect_to article_path(@article)
    end
  end
end

# It is accepted best practice to set the actual association proxy
# of an Active Record relationship than the _id method
class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter = current_user
    @version = @article.versions.build(params[:version])
    @version.writer = current_user

    if @article.save
      render action: :index
    else
      redirect_to article_path(@article)
    end
  end
end

# using new_version getter and setter

class ArticlesController < ApplicationController
  def create
    @article = Article.new(params[:article])
    @article.reporter = current_user
    @article.new_version.writer = current_user

    if @article.save
      render action: :index
    else
      redirect_to article_path(@article)
    end
  end
end
