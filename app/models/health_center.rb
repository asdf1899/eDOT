class HealthCenter < ApplicationRecord
  has_many :community_health_workers
  has_many :patients
end
