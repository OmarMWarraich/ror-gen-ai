# a static accessor for our json

class Styles
  def self.load
    cached_styles = Rails.cache.read('cached_styles')
    return cached_styles if cached_styles

    # no cache, load from file
    file_path = Rails.root.join('config', 'styles.json')
    styles = JSON.parse(File.read(file_path), symbolize_names: true)

    Rails.cache.write('cached_styles', styles, expires_in: 1.hour)

    styles
  end

  def self.find_by_name(name)
    all_styles = load
    all_styles.find { |style| style[:name] == name }
  end
end
