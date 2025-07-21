class User::Import
  include ActiveModel::Model
  attr_accessor :file, :imported_count

    def self.model_name
    ActiveModel::Name.new(self, nil, "User::Import")
  end

  def process!
    errors.add(:base, "ERROR!")
  end

  def save
    process!
    errors.none?
  end
end