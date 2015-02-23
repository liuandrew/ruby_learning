def caesar_cipher(word, shift)
        product = ""
        for i in 0..word.length-1
            if word[i].ord + shift > 122
                product += (word[i].ord + shift - 26).chr
            elsif word[i].ord + shift < 97
                product += (word[i].ord + shift + 26).chr
            else
                product += (word[i].ord + shift).chr
            end
        end
        product
    end
