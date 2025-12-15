#!/usr/bin/env ruby
# verify_structure.rb - Verify gem structure is complete

require 'pathname'

class GemVerifier
  REQUIRED_FILES = [
    'flash_messages.gemspec',
    'lib/flash_messages.rb',
    'lib/flash_messages/version.rb',
    'lib/flash_messages/engine.rb',
    'lib/flash_messages/controller_helpers.rb',
    'lib/flash_messages/view_helper.rb',
    'lib/flash_messages/generators/flash_messages/install_generator.rb',
    'app/views/flash_messages/_flash.html.erb',
    'app/views/flash_messages/_flash_message.html.erb',
    'app/assets/javascripts/flash_messages/controllers/flash_controller.js',
    'README.md',
    'CHANGELOG.md',
    'MIT-LICENSE',
    'Rakefile',
    'Gemfile'
  ]
  
  COLORS = {
    green: "\e[32m",
    red: "\e[31m",
    yellow: "\e[33m",
    cyan: "\e[36m",
    reset: "\e[0m"
  }
  
  def initialize(path = '.')
    @path = Pathname.new(path)
    @errors = []
  end
  
  def verify
    puts colorize("="*60, :cyan)
    puts colorize("Flash Messages Gem Structure Verification", :cyan)
    puts colorize("="*60, :cyan)
    puts
    
    check_required_files
    check_gemspec_content
    check_version_file
    
    print_summary
  end
  
  private
  
  def check_required_files
    puts colorize("Checking required files...", :cyan)
    
    REQUIRED_FILES.each do |file|
      file_path = @path.join(file)
      if file_path.exist?
        puts colorize("  ✓ #{file}", :green)
      else
        puts colorize("  ✗ #{file} - MISSING!", :red)
        @errors << "Missing file: #{file}"
      end
    end
    puts
  end
  
  def check_gemspec_content
    puts colorize("Checking gemspec content...", :cyan)
    
    gemspec_path = @path.join('flash_messages.gemspec')
    if gemspec_path.exist?
      content = File.read(gemspec_path)
      
      if content.include?('Your Name')
        puts colorize("  ⚠ Author name not updated (still 'Your Name')", :yellow)
        @errors << "Update author name in gemspec"
      else
        puts colorize("  ✓ Author name updated", :green)
      end
      
      if content.include?('your.email@example.com')
        puts colorize("  ⚠ Email not updated (still 'your.email@example.com')", :yellow)
        @errors << "Update email in gemspec"
      else
        puts colorize("  ✓ Email updated", :green)
      end
      
      if content.include?('yourusername')
        puts colorize("  ⚠ Homepage URL not updated (still has 'yourusername')", :yellow)
        @errors << "Update homepage URL in gemspec"
      else
        puts colorize("  ✓ Homepage URL updated", :green)
      end
    end
    puts
  end
  
  def check_version_file
    puts colorize("Checking version...", :cyan)
    
    version_path = @path.join('lib/flash_messages/version.rb')
    if version_path.exist?
      content = File.read(version_path)
      if content =~ /VERSION\s*=\s*["'](\d+\.\d+\.\d+)["']/
        puts colorize("  ✓ Version: #{$1}", :green)
      else
        puts colorize("  ✗ Could not find version number", :red)
        @errors << "Version number not found in version.rb"
      end
    end
    puts
  end
  
  def print_summary
    puts colorize("="*60, :cyan)
    if @errors.empty?
      puts colorize("✓ All checks passed!", :green)
      puts colorize("\nYour gem structure is complete and ready!", :green)
      puts colorize("\nNext steps:", :cyan)
      puts "  1. Review ACTION_PLAN.md"
      puts "  2. Build gem: gem build flash_messages.gemspec"
      puts "  3. Test locally: gem install ./flash_messages-1.0.0.gem"
      puts "  4. Publish: gem push flash_messages-1.0.0.gem"
    else
      puts colorize("⚠ Issues found:", :yellow)
      @errors.each do |error|
        puts colorize("  - #{error}", :yellow)
      end
      puts
      puts colorize("Please fix these issues before publishing.", :yellow)
    end
    puts colorize("="*60, :cyan)
  end
  
  def colorize(text, color)
    "#{COLORS[color]}#{text}#{COLORS[:reset]}"
  end
end

# Run verification
if __FILE__ == $PROGRAM_NAME
  verifier = GemVerifier.new(ARGV[0] || '.')
  verifier.verify
end
