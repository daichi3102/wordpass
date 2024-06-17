# app/helpers/informations_helper.rb
module InformationsHelper
  def unchecked_informations
    current_user.passive_informations.where(checked: false)
  end
end
