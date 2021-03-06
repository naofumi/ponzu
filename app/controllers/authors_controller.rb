# encoding: utf-8
class AuthorsController < ApplicationController
  authorize_resource :except => [:show]
  respond_to :html, :js, :json
  include Kamishibai::ResponderMixin

  set_kamishibai_expiry [:show] => 1 * 60 * 60

  before_filter do |c|
    @menu = :home
    # @expiry = 60 * 60 # seconds
  end

  # GET /authors
  # GET /authors.json
  def index
    if params[:query].blank?
      @authors = Author.in_conference(current_conference).
                        paginate(:page => params[:page], :per_page => 30)
    else
      tokens = params[:query].split(/ |　/)
      @authors = Author.in_conference(current_conference).
                        paginate(:page => params[:page], :per_page => 30)
      tokens.each do |t|
        @authors = @authors.where("jp_name LIKE ? OR en_name LIKE ?", "%#{t}%", "%#{t}%")
      end
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.in_conference(current_conference).
                     find(params[:id])

    respond_to do |format|
      format.html {
        device_selective_render
      }
    end
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    if params[:initial_authorship]
      @authorship = Authorship.find(params[:initial_authorship])
      @author = Author.new(:en_name => @authorship.en_name,
                           :jp_name => @authorship.jp_name)
    else
      @author = Author.new
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /authors/1/edit
  def edit
    @author = Author.in_conference(current_conference).
                     find(params[:id])
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(params[:author])
    @author.conference_confirm = current_conference

    respond_to do |format|
      if @author.save
        flash[:notice] = "Author was successfully created"
        if request.xhr?
          format.js {js_redirect ksp(edit_author_path @author)}
        else
          format.html { redirect_to @author}
        end
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])
    @author.conference_confirm = current_conference

    respond_to do |format|
      if @author.update_attributes(params[:author])
        flash[:notice] = 'Author was successfully updated.'
        if request.xhr?
          format.html { render action: "edit"}
        else
          format.html { redirect_to @author }
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.in_conference(current_conference).find(params[:id])
    @author.destroy

    respond_with @author
  end

  def replace
    @author = Author.in_conference(current_conference).find(params[:id])
    Authorship.transaction do
      if url = params[:data_transfer]['text/plain']
        logger.info "HOWDY"
        logger.info url
        url =~ /authorships\/(\d+)/
        @authorship = Authorship.in_conference(current_conference).find($1)
        @authorship.author = @author
        @authorship.save!
      end
    end

    respond_to do |format|
      format.html { render :partial => 'authorships', :object => @author.authorships}
    end
  end
end
