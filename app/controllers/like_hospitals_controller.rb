class LikeHospitalsController < ApplicationController
  include Pagy::Backend
  def list
    like = LikeHospital.select("hospital_id").where(user_id: current_user.id)
    @pagy, @hospital = pagy(Hospital.where(id: like), items:2)
    
    # 전체 필드를 조회했을 때, hospital_id 추출
    # likeIds = Array.new
    # like.each do |x|
    #   likeIds << x.hospital_id
    # end
    
    # Hospital.find(ids) => Array
    # Hospital.where(Key: value) => ActiveRecord
  end
end
