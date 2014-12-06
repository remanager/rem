module ApplicationHelper
  def get_permalink(*args)
    args.map { |arg| send(arg).to_s }
      .join(' ').match(/^.{0,40}\b/)[0].downcase
      .strip.gsub(/\s+/, '-').gsub(/-+/, '-')
  end
end
