require 'rails_helper'
RSpec.describe Puzzle, type: :model do

  describe "assesses the difficulty of the puzzle" do
    let(:very_easy) { Puzzle.new({ board: [
      9,5,0,3,7,4,0,6,0,
      0,8,0,9,0,0,2,7,0,
      6,1,0,0,0,8,4,0,9,
      2,0,0,0,9,0,1,5,8,
      0,3,9,8,0,6,7,0,0,
      0,4,1,0,5,7,0,0,3,
      1,0,8,7,0,0,9,0,2,
      7,0,5,0,4,0,0,8,0,
      0,0,3,6,8,2,0,1,7
      ]}).setup_puzzle
    }

    let(:easy) { Puzzle.new({ board: [
      7,0,9,0,0,0,3,0,0,
      4,0,6,3,5,0,9,0,0,
      0,0,0,0,0,0,0,1,6,
      0,4,0,0,2,9,0,6,3,
      9,0,0,4,0,5,0,0,8,
      5,6,0,7,3,0,0,9,0,
      3,2,0,0,0,0,0,0,0,
      0,0,8,0,4,7,6,0,5,
      0,0,4,0,0,0,1,0,2
      ]}).setup_puzzle
    }

    let(:medium) { Puzzle.new({ board: [
      3,0,0,2,0,0,6,9,0,
      8,0,0,3,6,0,4,0,7,
      0,0,0,0,0,0,0,0,3,
      0,1,0,7,0,0,8,4,0,
      0,7,8,0,2,0,3,1,0,
      0,3,6,0,0,4,0,7,0,
      1,0,0,0,0,0,0,0,0,
      7,0,4,0,3,9,0,0,5,
      0,6,2,0,0,8,0,0,4
      ]}).setup_puzzle
    }

    let(:hard) { Puzzle.new({ board: [
      1,0,0,4,5,9,0,0,0,
      8,0,3,0,7,0,9,0,0,
      0,0,0,0,0,8,0,0,0,
      5,0,8,0,0,2,6,0,0,
      9,0,0,0,6,0,0,0,7,
      0,0,7,9,0,0,1,0,5,
      0,0,0,2,0,0,0,0,0,
      0,0,6,0,8,0,2,0,4,
      0,0,0,5,9,4,0,0,3
      ]}).setup_puzzle
    }

    let(:very_hard) { Puzzle.new({ board: [
      0,2,0,0,0,1,0,9,0,
      8,0,0,0,0,5,0,0,0,
      0,5,9,0,8,0,0,0,0,
      0,0,5,7,0,0,0,0,1,
      0,8,3,0,0,0,9,7,0,
      1,0,0,0,0,3,6,0,0,
      0,0,0,0,2,0,3,5,0,
      0,0,0,6,0,0,0,0,4,
      0,9,0,4,0,0,0,6,0
      ]}).setup_puzzle
    }

    it "#given determines the number of cells given" do
      expect(very_easy.given).to eq(45)
      expect(easy.given).to eq(34)
      expect(medium.given).to eq(33)
      expect(hard.given).to eq(29)
      expect(very_hard.given).to eq(26)
    end

  end
end
