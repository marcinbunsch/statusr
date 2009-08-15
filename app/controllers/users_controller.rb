class UsersController < Application
  # Be sure to include AuthenticationSystem in Application Controller instead
  
  before_filter :login_required, :except => [:new, :create]
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        self.current_user = @user
        flash[:notice] = "Thanks for signing up!"
        format.html { redirect_back_or_default('/') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /users
  # GET /users.xml
  def index
    redirect_to('/')
    return
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @statuses = Status.find(:all, :conditions => 'user_id = ' + @user.id.to_s).sort_by { |status| status.created_at }.reverse
    @status = Status.new
    respond_to do |format|
      format.html { render :template => 'statuses/index' }
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end


  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def follow
    if (params[:id]) 
      friend = User.find(params[:id])
      if friend
        object = Friend.new
        object.user = current_user
        object.friend = friend
        object.save
        current_user.friends << object
        current_user.save
        flash[:notice] = "You are following #{friend.login}"
        redirect_to('/')
      end
    end
  end
  
  def unfollow
    if (params[:id]) 
      friend = Friend.find(:first, :conditions => "user_id = #{current_user.id} and friend_id = #{params[:id]}")
      if friend
        friend.destroy
        flash[:notice] = "You are not following #{friend.friend.login} anymore"
        redirect_to('/')
      end
    end
  end

end
