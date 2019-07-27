class LikeHospitalsController < ApplicationController
  def list
    @like_hospital = LikeHospital.all
  end
end
