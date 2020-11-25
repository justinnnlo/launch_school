def test_odd
  assert_equal(true, value.odd?)                              # true == value.odd?
  assert(value.odd?, "value is not odd")                      # assert tests whether its first argument (value.odd?) is truthy, otherwise the 2nd arg is displayed as the failure message
end

def test_downcase
  assert_equal("xyz", value.downcase)                         # 1st arg is expected value, 2nd is actual value
end

def test_nil
  assert_nil(value)                                           # Preferable because it's clearer and has a better error message
  assert_equal(nil, value)                                    # Alternative with equality comparison
end

def test_empty
  assert_empty(list)                                          # Preferable because it's clearer and has a better error message
  assert_equal(0, list.size)                                  # Size of list should be 0 using comparison
  assert_equal(true, list.empty?)                             # Same as above but with #empty? and true
end

def test_element_in_array
  assert_includes(list, "xyz")                                # Preferable because it's clearer and has a better error message
  assert_equal(true, list.include?("xyz"))
end

def test_exception
  assert_raises(NoExperienceError) { employee.hire }          # assert_raises should be passed a block with the test
end

def test_numeric
  assert_instance_of(Numeric, value)                          # Tests for class using Object#instance_of? — 2nd being instance of 1st
  assert_equal(Numeric, value.class)
end

def test_numeric_superclass
  assert_kind_of(Numeric, value)                              # Tests for class using Object#kind_of? — 2nd being instance or descendent of 1st
  assert_equal(true, Numeric.ancestors.include?(value.class))
end

def test_object_id
  asser_same(list, list.process)                              # Compares object ids using #eql?
  asser_equal(list.object_id, list.process.object_id)
end

def test_refute_element_in_array
  refute_includes(list, "xyz")                                # refutation of assert_includes
  assert_equal(true, list.include?("xyz"))
end