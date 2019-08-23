class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token
  include Pagy::Backend
  #Pagy::VARS[:page_param] = :custom_param
  # GET /pets
  # GET /pets.json
  def index
    @pagy, @pets = pagy(Pet.where(user_id: current_user.id), items:5)
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
  end

  # GET /pets/new
  def new
    @pet = Pet.new
    # 동물종류 코드조회
    @pet_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='PET'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code");
  end

  # GET /pets/1/edit
  def edit

    
    @pet = Pet.find(params[:id])
    
    # 동물종류 코드조회
    @pet_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='PET'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code");
    #품종 세부항목 코드조회                             
    @breed = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='#{@pet.kind}'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
                                            
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(pet_params)

    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: 'Pet was successfully created.' }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: 'Pet was successfully updated.' }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Pet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_params
     # params.require(:pet).permit(:user_id, :name, :kind, :breed, :gender, :birth_date, :weight, :photo_file)
     params.permit(:user_id, :name, :kind, :breed, :gender, :birth_date, :weight, :photo_file, :age)
    end
end
