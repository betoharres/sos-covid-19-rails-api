class PhoneCleanupJob < ApplicationJob
  queue_as :default

  def perform(new_phone_id)
    phone = Phone.find(new_phone_id)
    phone.destroy! unless phone.is_verified?
  end
end
