class Note < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, length: { maximum: 5000 }

  def self.by_letter(letter)
    where("title LIKE ?", "#{letter}%").order(:title)
  end

  def blurb
    "#{title} #{content}".slice(0,255)
  end
end
