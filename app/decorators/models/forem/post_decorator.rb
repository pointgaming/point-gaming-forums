Forem::Post.class_eval do
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Forem::Engine.routes.url_helpers

  def store_sort
    100   
  end 

  def main_sort
    100  
  end 

  def forum_sort
    0 
  end

  mapping do
    indexes :_id, type: 'string', index: :not_analyzed, as: 'id'
    indexes :display_name, type: 'string', analyzer: 'snowball', as: 'topic.subject'
    indexes :forum, type: 'string', analyzer: 'snowball', as: 'topic.forum.name'
    indexes :description, type: 'string', boost: 10, analyzer: 'snowball', as: 'text'
    indexes :url, type: 'string', :index => 'no', as: 'url'

    indexes :store_sort, type: 'short', :index => 'not_analyzed', as: 'store_sort'
    indexes :main_sort, type: 'short', :index => 'not_analyzed', as: 'main_sort'
    indexes :forum_sort, type: 'short', :index => 'not_analyzed', as: 'forum_sort'
  end

  def url
    forum_topic_url(self.topic.forum, self.topic)
  end

end
