module ApplicationHelper
  def generate_permalink(*args)
    args.map(&:to_s).join('-').downcase.gsub(/\s+/, '-').gsub(/-+/, '-')
  end
end
