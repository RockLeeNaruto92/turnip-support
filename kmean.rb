require "ap"
require "colorize"
require "pry"

@num_of_points = 6
@num_of_dimensions = 2
@k = 2

def main
  points_set = random_sets(@num_of_points, @num_of_dimensions)

  info "Random points_set: "
  ap points_set

  groups = init_groups points_set, @k

  ap groups

  # k is number of groups

  # groups = [{
  #   cendoird_point: (x, y),
  #   points: [(x1, y1), (x2, y2)],
  #   stop_flag: true/false
  # }]

  loop_index = 1

  until is_stop? groups
    warning "------------------------【LOOP #{loop_index}】------------------------"
    loop_index += 1

    points_set.each{|point| set_group_for_point point, groups}

    recalculate_cendroid_points(groups)
  end

  output groups
end

def init_groups points_set, k
  groups = Array.new

  k.times do
    loop do
      point = points_set[Random.rand(points_set.length)]
      unless groups.map{|g| g[:cendoird_point]}.include? point
        groups << {
          cendoird_point: point,
          stop_flag: false,
          points: Array.new
        }
        break
      end
    end
  end

  return groups
end

def random_sets num_of_points, num_of_dimensions
  set = Array.new

  num_of_points.times do
    point = case num_of_dimensions
    when 1
      {x: Random.rand(1000)}
    when 2
      {x: Random.rand(1000), y: Random.rand(1000)}
    when 3
      {x: Random.rand(1000), y: Random.rand(1000), z: Random.rand(1000)}
    end

    set << point
  end

  return set
end

def is_stop? groups
  groups.select{|g| g[:stop_flag]}.length == groups.length
end

def set_group_for_point point, groups
  info ">>> Start to set group for point: (#{point[:x]}, #{point[:y]})"

  min_distance = 1000000000
  new_group = nil

  groups.each_with_index do |group, index|
    c_point = group[:cendoird_point]
    d = Math.sqrt((point[:x] - c_point[:x]) ** 2 + (point[:y] - c_point[:y]) ** 2)
    info ">>>>>> Distance from point to cendoird_point (#{c_point[:x]}, #{c_point[:y]}):  #{d}"

    if min_distance > d
      warning ">>>>>> Set min_distance = #{d}"
      min_distance = d
      new_group = group
    end
  end

  unless new_group == point[:current_group]
    warning ">>>>>> Add new group to point"
    new_group[:points] << point
    point[:current_group]&.delete point
    point[:current_group] = new_group
  end
end

def recalculate_cendroid_points groups
  info ""
  info ">>> Recalculate cendoird_points"

  groups.each_with_index do |group, index|
    info ">>>>>> Group #{index + 1}"
    if group[:stop_flag]
      warning "Next"
      next
    end

    total_x = group[:points].map{|p| p[:x]}.inject(:+).to_f
    total_y = group[:points].map{|p| p[:y]}.inject(:+).to_f

    new_cx = total_x / group[:points].length
    new_cy = total_y / group[:points].length

    if new_cx = group[:cendoird_point][:x] && new_cy = group[:cendoird_point][:y]
      info ">>>>>>>>> group[:stop_flag] = true"
      group[:stop_flag] = true
    else
      info ">>>>>>>>> group[:cendoird_point] = #{{x: new_cx, y: new_cy}.inspect}"
      group[:cendoird_point] = {x: new_cx, y: new_cy}
    end
  end
end

def output groups
  info ">>> Output: "
  groups.each_with_index do |group, index|
    info ">>>>>> Group #{index + 1}"
    group[:points].each do |p|
      res ">>>>>>>>> (#{p[:x]}, #{p[:y]})"
    end
  end
end

def info msg
  puts "[INFO]:\t\t#{msg}".green
end

def warning msg
  puts "[WARN]:\t\t#{msg}".yellow
end

def res msg
  puts "[WARN]:\t\t#{msg}".red
end

main
