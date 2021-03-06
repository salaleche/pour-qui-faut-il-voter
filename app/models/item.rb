class Item < ActiveRecord::Base

  default_scope order('created_at DESC')

  LIST_NAMES = ['Baba Forum','Forum Boyard']

  validates :title, presence: true
  validates :list, presence: true, inclusion: {in: -1.upto(LIST_NAMES.length-1)}
  validates :points, presence: true, numericality: {only_integer: true}


  def list_name
    if challenge?
      "Challenge"
    else
      LIST_NAMES[list]
    end
  end

  def challenge?
    list == -1
  end

  def self.total_points list
    Item.where('list = ?', list).sum(:points)
  end

  def self.best_list
    0.upto(LIST_NAMES.length-1).map { |l| total_points l }.each_with_index.max[1]
  end

end