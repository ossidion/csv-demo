require 'csv'


class User < ActiveRecord::Base
  # validations or associations here

  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  has_many :forum_threads
  has_many :forum_posts

  def self.import(file)
        counter = 0

    CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
      user = User.assign_from_row(row)
      if user.save
        counter += 1 
      else
        puts "#{user.email} - #{user.errors.full_messages.join(",")}"
      end
    end

    counter
  end

  def self.assign_from_row(row)
    user = User.where(email: row[:email]).first_or_initialize
    user.assign_attributes row.to_hash.slice(:first_name, :last_name)
    user
  end

  def self.to_csv
    attributes = %w{id email first_name last_name}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  def name
    if deleted_at?
      "Deleted User"
    else
      "#{first_name} #{last_name}"
    end
  end
end
