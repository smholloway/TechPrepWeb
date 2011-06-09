class PocketrefController < ApplicationController
  def index
    if params[:product]
      @questions = Question.tagged_with(params[:product]).order('id ASC')
    else
      @questions = Question.order('id ASC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  def show
    @question = Question.find(params[:id])
    @tags = @question.tags

    @prod = params[:product] if params[:product]
    @id = params[:id] if params[:id]

    if @prod and @id
      @prev = Question.tagged_with(@prod).where("Questions.id < #{@id}").order('id DESC').limit(1).first
      @next = Question.tagged_with(@prod).where("Questions.id > #{@id}").order('id ASC').limit(1).first
    else
      @prev = @next = nil
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

end
