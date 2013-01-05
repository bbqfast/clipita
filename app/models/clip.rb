require Rails.root.to_s + '/UniqueClip.rb'

class Clip < ActiveRecord::Base

  before_save :check_name
  def check_name
    if name.nil?
      raise 'null name error'
    end
  end

def as_json(options={})
  super( :methods =>[:updated_js] )
end

  def updated_js
    # x 1000 to make it javascript compliant
    updated_at.to_i * 1000
  end

  def self.next_clip
    latest = Clip.find(:all, :conditions => [ "user_id is null" ], :order => "id desc", :limit => 1).reverse.first

    if latest.nil?
      latest=save_empty_paste('aaa')
      return latest
    else
      if latest.name.nil?
        raise 'latest has no name'
      end
    Mylog.log.info('latest name=' + latest.name)

      newname = UniqueClip.next_str latest.name
      latest=save_empty_paste(newname)
      return latest
    end
  end

  def self.save_empty_paste(name)
    clip1=Clip.new(:name => name)
    clip1.save
    return clip1
  end

  def self.create_with_content(uid, oldtext, userid)
    Mylog.log.info('create_with_content' + uid)
    clip2=Clip.new(:name => uid, :paste => oldtext, :user_id => userid)
    clip2.save
    return clip2
  end
  

  belongs_to :user
  belongs_to :history
   attr_accessible :name, :paste, :updated_at, :user_id
   validates_uniqueness_of :name
end
