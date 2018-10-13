class ArticlesController < ApplicationController

    # A frequent practice is to place the standard CRUD actions in each controller in the following order:
    # index, show, new, edit, create, update and destroy.

    def index
        @articles = Article.all
    end

    def show
        # We also use an instance variable (prefixed with @) to hold a reference to the article object.
        # We do this because Rails will pass all instance variables to the view.
        @article = Article.find(params[:id])
    end

    def new
        # The reason why we added @article = Article.new in the ArticlesController is that otherwise @article would be nil in our view,
        # and calling @article.errors.any? would throw an error.
        @article = Article.new
    end

    def edit
       @article = Article.find(params[:id])
    end

    def create
        # Initialize the Article model with its respective attributes (pulled from params in article_params helper)
        @article = Article.new(article_params)

        if @article.save
            # Redirect the user to the show action
            redirect_to @article
        else
            # Notice that we use render instead of redirect_to when save returns false.
            # The render method is used so that the @article object is passed back to the new template when it is rendered.
            # This rendering is done within the same request as the form submission, whereas redirect_to will issue another request.
            render 'new'
        end
    end

    def update
        @article = Article.find(params[:id])

        # It is not necessary to pass all the attributes to update.
        # For example, if @article.update(title: 'A new title') was called,
        # Rails would only update the title attribute, leaving all other attributes untouched.
        if @article.update(article_params)
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

    private
      def article_params
        # reusable helper for strong parameters
        # requires us to tell Rails exactly which parameters are allowed into our controller actions.
        params.require(:article).permit(:title, :text)
      end

end
