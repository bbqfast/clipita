
# class in model
class UniqueClip
  def self.next_char(a)
    if a=='z'
      return 'a'
    end
    (a.ord + 1).chr
  end

  def self.next_char_with_carry(a)
    if a[:char]=='z'
      a[:carry]=true
      return 'a'
    end
    a[:carry]=false
    (a[:char].ord + 1).chr
  end

  def self.pof_loop_str(s)
    for i in 0..s.length
      #puts i.to_s
      print s[i]
    end
    puts
  end

  def self.next_str(s)
    for i in (0..s.length-1).to_a.reverse
      puts "i=#{i}"
      h={:char => s[i]}
      nc=next_char_with_carry h
      s[i]=nc
      if !h[:carry]
        break
      end
      # puts 'carry'
    end
    return s
  end
end

#puts 'random'

#puts next_char 'b'
#puts next_char_with_carry :char => 'b'
#pof_loop_str 'abc'
##puts "ab"[0]
UniqueClip.next_str 'aaa'
#next_str 'aaz'
#UniqueClip.next_str 'azz'