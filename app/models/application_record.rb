class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_initialize :_uuid_

protected

  def _uuid_
    self.id = SecureRandom.uuid if self.id.blank?
  end
end
