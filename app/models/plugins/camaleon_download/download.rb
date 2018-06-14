class Download < ApplicationRecord

  def user
    CamaleonCms::User.find(user_id).try(:first_name)
  end

  def file
    metadata["file_name"]
  end
end
