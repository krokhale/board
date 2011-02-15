class Post < ActiveRecord::Base
  belongs_to :feed
  
  def self.form_array
      one = Post.where(:created_at => (Time.now.midnight - 1.day)..Time.now).count
      two = Post.where(:created_at => (Time.now.midnight - 2.day)..Time.now).count - one
      three = Post.where(:created_at => (Time.now.midnight - 3.day)..Time.now).count - two
      four = Post.where(:created_at => (Time.now.midnight - 4.day)..Time.now).count - three
      five = Post.where(:created_at => (Time.now.midnight - 5.day)..Time.now).count - four
      six = Post.where(:created_at => (Time.now.midnight - 6.day)..Time.now).count - five
      seven = Post.where(:created_at => (Time.now.midnight - 7.day)..Time.now).count - six
      eight = Post.where(:created_at => (Time.now.midnight - 8.day)..Time.now).count - seven
      nine = Post.where(:created_at => (Time.now.midnight - 9.day)..Time.now).count - eight
      ten = Post.where(:created_at => (Time.now.midnight - 10.day)..Time.now).count - nine
      return [one,two,three,four,five,six,seven,eight,nine,ten]
  end



end
