class ArticlesController < ApplicationController

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end


    def create
        #render plain: params[:article]
        #↑だと、/new でsubmitボタンが押された時、フォームに入力した値をそのまま出力するようになる。
        #@article = Article.new(params[:article])
        #↑だと、strongパラメータが設定されていないのでsubmitボタンが押されるとエラーが出る
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
        #render plain: @article.inspect #このinspexctがないと、titleやdescriptionが表示されない
        #redirect_to article_path(@article)#rails routesで確認して、URIが/articles/:id(.:format) になってるから@articleも入れる。
        flash[:notice] = "Article was created successfully"
        redirect_to @article
        else
            render 'new'
        end

    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end

    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end
end