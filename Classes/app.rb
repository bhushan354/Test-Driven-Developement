require 'date'
require_relative 'game'
require_relative 'author_service'
require_relative 'utils/util'
require_relative 'game_service'

class App
  def initialize
    @all_things = []

    # All subclass of item class (Book, MusicAlbum, Movie, and Game) should be push here
    @items = []

    @author_manager = AuthorService.new
    @game_creator = GameService.new(@author_manager, @items)
  end

  def create_book
    print 'Date of publishing: '
    date = gets.chomp

    book = Book.new(date)
    @all_things << book
    puts 'Item Created Successfully'
  end

  def list_authors
    @author_manager.list_authors
  end

  def list_items
    if @items.empty?
      puts "Item is empty\n\n"
    else
      puts "\nList of Items:"
      @items.each_with_index do |item, i|
        author_first_name = item&.author ? " Author: \"#{item.author.first_name} #{item.author.last_name}\" " : nil
        puts "  #{i} | [#{item.class.name}] -#{author_first_name}Publish Date: #{item.publish_date}. id: #{item.id}"
      end
      puts ''
    end
  end

  def create_author
    @author_manager.create_author
  end

  def create_item
    loop do
      puts 'Select choice'
      puts '  1. To create game'
      puts '  0. Back to App menu'
      print 'Add Items >> '
      choice = gets.chomp.to_i
      puts "\n"

      case choice
      when 1
        create_game
      when 0
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def list_items_menu
    loop do
      list_menu_option_display
      choice = gets.chomp.to_i
      puts "\n"

      case choice
      when 1
        @game_creator.list
      when 2
        puts "MusicAlbum listing functionality is not yet implemented.\n\n"
      when 3
        puts "Book listing functionality is not yet implemented.\n\n"
      when 4
        list_items
      when 0
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  def create_game
    @game_creator.create_game
  end

  private

  def list_menu_option_display
    puts 'Select choice'
    puts '  1. To list games'
    puts '  2. To list MusicAlbum (not yet available)'
    puts '  3. To list books (not yet available)'
    puts '  4. To list all items'
    puts '  0. Back to App menu'
    print 'List Items >> '
  end
  # you can add your required def here
end
