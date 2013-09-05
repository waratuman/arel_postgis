require 'test_helper'

class Arel::Visitors::PostGISTest < MiniTest::Unit::TestCase

  def setup
    @visitor = Arel::Visitors::PostGIS.new Arel::Table.engine.connection
  end

  # = Geometry Constructors ==================================================

  test 'should visit ST_MakePoint' do
    function = Arel::Nodes::Spatial::ST_MakePoint.new([1, 2])
    assert_equal 'ST_MakePoint(1, 2)', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MakePoint.new([1, 2, 3])
    assert_equal 'ST_MakePoint(1, 2, 3)', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MakePoint.new([1, 2, 3, 4.5])
    assert_equal 'ST_MakePoint(1, 2, 3, 4.5)', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MakePoint.new([1, 2])
    function.as('point')
    assert_equal 'ST_MakePoint(1, 2) AS point', @visitor.accept(function)
  end

  test 'should visit ST_MakePointM' do
    function = Arel::Nodes::Spatial::ST_MakePointM.new([1, 2, 3])
    assert_equal 'ST_MakePointM(1, 2, 3)', @visitor.accept(function)
  end

  test 'should visit ST_MakeLine' do
    function = Arel::Nodes::Spatial::ST_MakeLine.new([Arel::Table.new(:regions)[:geometry]])
    assert_equal 'ST_MakeLine("regions"."geometry")', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MakeLine.new([Arel::Nodes::Spatial::ST_MakePoint.new([1, 2]), Arel::Nodes::Spatial::ST_MakePoint.new([3, 4])], )
    assert_equal 'ST_MakeLine(ST_MakePoint(1, 2), ST_MakePoint(3, 4))', @visitor.accept(function)
  end

  test 'should visit ST_MakeEnvelope' do
    function = Arel::Nodes::Spatial::ST_MakeEnvelope.new([1, 2, 3, 4])
    assert_equal 'ST_MakeEnvelope(1, 2, 3, 4)', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MakeEnvelope.new([1, 2, 3, 4, 4326])
    assert_equal 'ST_MakeEnvelope(1, 2, 3, 4, 4326)', @visitor.accept(function)
  end

  test 'should visit ST_Point' do
    function = Arel::Nodes::Spatial::ST_Point.new([1, 2])
    assert_equal 'ST_Point(1, 2)', @visitor.accept(function)    
  end

  test 'should visit ST_PointFromText' do
    function = Arel::Nodes::Spatial::ST_PointFromText.new(['POINT(-71.064544 42.28787)'])
    assert_equal 'ST_PointFromText(\'POINT(-71.064544 42.28787)\')', @visitor.accept(function)    

    function = Arel::Nodes::Spatial::ST_PointFromText.new(['POINT(-71.064544 42.28787)', 4326])
    assert_equal 'ST_PointFromText(\'POINT(-71.064544 42.28787)\', 4326)', @visitor.accept(function)    
  end

  test 'should visit ST_MakePolygon' do
    function = Arel::Nodes::Spatial::ST_MakePolygon.new([Arel::Nodes::Spatial::ST_GeomFromText.new(['LINESTRING(75.15 29.53,77 29,77.6 29.5, 75.15 29.53)'])])
    assert_equal 'ST_MakePolygon(ST_GeomFromText(\'LINESTRING(75.15 29.53,77 29,77.6 29.5, 75.15 29.53)\'))', @visitor.accept(function)
  end

  test 'should visit ST_GeomFromText' do
    function = Arel::Nodes::Spatial::ST_GeomFromText.new(['LINESTRING(75.15 29.53,77 29,77.6 29.5, 75.15 29.53)'])
    assert_equal 'ST_GeomFromText(\'LINESTRING(75.15 29.53,77 29,77.6 29.5, 75.15 29.53)\')', @visitor.accept(function)
  end

  test 'should visit ST_MLineFromText' do
    function = Arel::Nodes::Spatial::ST_MLineFromText.new(['MULTILINESTRING((1 2, 3 4), (4 5, 6 7))'])
    assert_equal 'ST_MLineFromText(\'MULTILINESTRING((1 2, 3 4), (4 5, 6 7))\')', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MLineFromText.new(['MULTILINESTRING((1 2, 3 4), (4 5, 6 7))', 4326])
    assert_equal 'ST_MLineFromText(\'MULTILINESTRING((1 2, 3 4), (4 5, 6 7))\', 4326)', @visitor.accept(function)
  end

  test 'should visit ST_MPointFromText' do
    function = Arel::Nodes::Spatial::ST_MPointFromText.new(['MULTIPOINT(1 2, 3 4)'])
    assert_equal 'ST_MPointFromText(\'MULTIPOINT(1 2, 3 4)\')', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MPointFromText.new(['MULTIPOINT(1 2, 3 4)', 4326])
    assert_equal 'ST_MPointFromText(\'MULTIPOINT(1 2, 3 4)\', 4326)', @visitor.accept(function)
  end

  test 'should visit ST_MPolyFromText' do
    function = Arel::Nodes::Spatial::ST_MPolyFromText.new(['MULTIPOLYGON(((0 0 1,20 0 1,20 20 1,0 20 1,0 0 1),(5 5 3,5 7 3,7 7 3,7 5 3,5 5 3)))'])
    assert_equal 'ST_MPolyFromText(\'MULTIPOLYGON(((0 0 1,20 0 1,20 20 1,0 20 1,0 0 1),(5 5 3,5 7 3,7 7 3,7 5 3,5 5 3)))\')', @visitor.accept(function)

    function = Arel::Nodes::Spatial::ST_MPolyFromText.new(['MULTIPOLYGON(((0 0 1,20 0 1,20 20 1,0 20 1,0 0 1),(5 5 3,5 7 3,7 7 3,7 5 3,5 5 3)))', 4326])
    assert_equal 'ST_MPolyFromText(\'MULTIPOLYGON(((0 0 1,20 0 1,20 20 1,0 20 1,0 0 1),(5 5 3,5 7 3,7 7 3,7 5 3,5 5 3)))\', 4326)', @visitor.accept(function)
  end

  test 'should visit ST_Polygon' do
    function = Arel::Nodes::Spatial::ST_Polygon.new([Arel::Nodes::Spatial::ST_GeomFromText.new(['LINESTRING(75.15 29.53,77 29,77.6 29.5, 75.15 29.53)']), 4326])
    assert_equal 'ST_Polygon(ST_GeomFromText(\'LINESTRING(75.15 29.53,77 29,77.6 29.5, 75.15 29.53)\'), 4326)', @visitor.accept(function)
  end

  # = Geometry Operators =====================================================

  test 'should visit Intersection' do
    node = Arel::Nodes::Spatial::Intersection.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" && "regions"."geometry"', @visitor.accept(node)
  end

  test 'should visit Intersection3D' do
    node = Arel::Nodes::Spatial::Intersection3D.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" &&& "regions"."geometry"', @visitor.accept(node)
  end

  test 'should visit OverLeft' do
    node = Arel::Nodes::Spatial::OverLeft.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" &< "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit OverBelow' do
    node = Arel::Nodes::Spatial::OverBelow.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" &<| "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit OverRight' do
    node = Arel::Nodes::Spatial::OverRight.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" &> "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Left' do
    node = Arel::Nodes::Spatial::Left.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" << "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Below' do
    node = Arel::Nodes::Spatial::Below.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" <<| "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Equal' do
    node = Arel::Nodes::Spatial::Equal.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" = "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Right' do
    node = Arel::Nodes::Spatial::Right.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" >> "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Contained' do
    node = Arel::Nodes::Spatial::Contained.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" @ "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit OverAbove' do
    node = Arel::Nodes::Spatial::OverAbove.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" |&> "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Above' do
    node = Arel::Nodes::Spatial::Above.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" |>> "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Contains' do
    node = Arel::Nodes::Spatial::Contains.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" ~ "regions"."geometry"', @visitor.accept(node)
  end

  test 'should visit Same' do
    node = Arel::Nodes::Spatial::Same.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" ~= "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit Distance' do
    node = Arel::Nodes::Spatial::Distance.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" <-> "regions"."geometry"', @visitor.accept(node)
  end
  
  test 'should visit BoundingBoxDistance' do
    node = Arel::Nodes::Spatial::BoundingBoxDistance.new(Arel::Table.new(:addresses)[:location], Arel::Table.new(:regions)[:geometry])
    assert_equal '"addresses"."location" <#> "regions"."geometry"', @visitor.accept(node)
  end

end