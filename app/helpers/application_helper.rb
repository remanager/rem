module ApplicationHelper
  def get_permalink(*args)
    args.map { |arg| self.send(arg).to_s }.join('-').gsub(/\s+/, '-').gsub(/-+/, '-')
  end
end
