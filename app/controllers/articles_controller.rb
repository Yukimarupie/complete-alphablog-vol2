class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    #privateで設定したパーソナルアクションを、必要なアクション内で呼び出す

    def show
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
    end


    def create
        #render plain: params[:article]
        #↑だと、/new でsubmitボタンが押された時、フォームに入力した値をそのまま出力するようになる。
        #@article = Article.new(params[:article])
        #↑だと、strongパラメータが設定されていないのでsubmitボタンが押されるとエラーが出る
        #@article = Article.new(params.require(:article).permit(:title, :description))
        #↑privateで設定したのでDRYで削除
        @article = Article.new(article_params)
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
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end

    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private #このコントローラ内でのみ使用可能

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

end