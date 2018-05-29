module ListsHelper

  def list_user
    @list.user
  end

  def self.last_updated(list)
    list.updated_at.strftime(" %B %Y")
  end
end
