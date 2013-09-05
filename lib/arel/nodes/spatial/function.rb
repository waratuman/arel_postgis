module Arel
  module Nodes
    module Spatial
      class Function < Arel::Nodes::Function
      end

      # Management Functions
      %w{
        AddGeometryColumn
        DropGeometryColumn
        DropGeometryTable
        PostGIS_Full_Version
        PostGIS_GEOS_Version
        PostGIS_LibXML_Version
        PostGIS_Lib_Build_Date
        PostGIS_Lib_Version
        PostGIS_PROJ_Version
        PostGIS_Scripts_Build_Date
        PostGIS_Scripts_Installed
        PostGIS_Scripts_Released
        PostGIS_Version
        Populate_Geometry_Columns
        UpdateGeometrySRID
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Geometry Constructors
      %w{
        ST_MakeLine
        ST_MakeEnvelope
        ST_MakePolygon
        ST_MakePoint
        ST_MakePointM
        ST_MLineFromText
        ST_MPointFromText
        ST_MPolyFromText
        ST_Point
        ST_PointFromText
        ST_Polygon

        ST_PolygonFromText
        ST_WKBToSQL
        ST_WKTToSQL
        ST_BdPolyFromText
        ST_BdMPolyFromText
        ST_GeogFromText
        ST_GeographyFromText
        ST_GeogFromWKB
        ST_GeomCollFromText
        ST_GeomFromEWKB
        ST_GeomFromEWKT
        ST_GeometryFromText
        ST_GeomFromGML
        ST_GeomFromGeoJSON
        ST_GeomFromKML
        ST_GMLToSQL
        ST_GeomFromText
        ST_GeomFromWKB
        ST_LineFromMultiPoint
        ST_LineFromText
        ST_LineFromWKB
        ST_LinestringFromWKB
        ST_MakeBox2D
        ST_3DMakeBox
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Geometry Accessors
      %w{
        GeometryType
        ST_Boundary
        ST_CoordDim
        ST_Dimension
        ST_EndPoint
        ST_Envelope
        ST_ExteriorRing
        ST_GeometryN
        ST_GeometryType
        ST_InteriorRingN
        ST_IsClosed
        ST_IsCollection
        ST_IsEmpty
        ST_IsRing
        ST_IsSimple
        ST_IsValid
        ST_IsValidReason
        ST_IsValidDetail
        ST_M
        ST_NDims
        ST_NPoints
        ST_NRings
        ST_NumGeometries
        ST_NumInteriorRings
        ST_NumInteriorRing
        ST_NumPatches
        ST_NumPoints
        ST_PatchN
        ST_PointN
        ST_SRID
        ST_StartPoint
        ST_Summary
        ST_X
        ST_XMax
        ST_XMin
        ST_Y
        ST_YMax
        ST_YMin
        ST_Z
        ST_ZMax
        ST_Zmflag
        ST_ZMin
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Geometry Editors
      %w{
        ST_AddPoint
        ST_Affine
        ST_Force_2D
        ST_Force_3D
        ST_Force_3DZ
        ST_Force_3DM
        ST_Force_4D
        ST_Force_Collection
        ST_ForceRHR
        ST_LineMerge
        ST_CollectionExtract
        ST_CollectionHomogenize
        ST_Multi
        ST_RemovePoint
        ST_Reverse
        ST_Rotate
        ST_RotateX
        ST_RotateY
        ST_RotateZ
        ST_Scale
        ST_Segmentize
        ST_SetPoint
        ST_SetSRID
        ST_SnapToGrid
        ST_Snap
        ST_Transform
        ST_Translate
        ST_TransScale
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Geometry Outputs
      %w{
        ST_AsBinary
        ST_AsEWKB
        ST_AsEWKT
        ST_AsGeoJSON
        ST_AsGML
        ST_AsHEXEWKB
        ST_AsKML
        ST_AsSVG
        ST_AsX3D
        ST_GeoHash
        ST_AsText
        ST_AsLatLonText
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Spatial Relationships and Measurements
      %w{
        ST_3DClosestPoint
        ST_3DDistance
        ST_3DDWithin
        ST_3DDFullyWithin
        ST_3DIntersects
        ST_3DLongestLine
        ST_3DMaxDistance
        ST_3DShortestLine
        ST_Area
        ST_Azimuth
        ST_Centroid
        ST_ClosestPoint
        ST_Contains
        ST_ContainsProperly
        ST_Covers
        ST_CoveredBy
        ST_Crosses
        ST_LineCrossingDirection
        ST_Disjoint
        ST_Distance
        ST_HausdorffDistance
        ST_MaxDistance
        ST_Distance_Sphere
        ST_Distance_Spheroid
        ST_DFullyWithin
        ST_DWithin
        ST_Equals
        ST_HasArc
        ST_Intersects
        ST_Length
        ST_Length2D
        ST_3DLength
        ST_Length_Spheroid
        ST_Length2D_Spheroid
        ST_3DLength_Spheroid
        ST_LongestLine
        ST_OrderingEquals
        ST_Overlaps
        ST_Perimeter
        ST_Perimeter2D
        ST_3DPerimeter
        ST_PointOnSurface
        ST_Project
        ST_Relate
        ST_RelateMatch
        ST_ShortestLine
        ST_Touches
        ST_Within
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Geometry Processing
      %w{
        ST_Buffer
        ST_BuildArea
        ST_Collect
        ST_ConcaveHull
        ST_ConvexHull
        ST_CurveToLine
        ST_Difference
        ST_Dump
        ST_DumpPoints
        ST_DumpRings
        ST_FlipCoordinates
        ST_Intersection
        ST_LineToCurve
        ST_MakeValid
        ST_MemUnion
        ST_MinimumBoundingCircle
        ST_Polygonize
        ST_Node
        ST_OffsetCurve
        ST_RemoveRepeatedPoints
        ST_SharedPaths
        ST_Shift_Longitude
        ST_Simplify
        ST_SimplifyPreserveTopology
        ST_Split
        ST_SymDifference
        ST_Union
        ST_UnaryUnion
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Linear Referencing
      %w{
        ST_Line_Interpolate_Point
        ST_Line_Locate_Point
        ST_Line_Substring
        ST_LocateAlong
        ST_LocateBetween
        ST_LocateBetweenElevations
        ST_InterpolatePoint
        ST_AddMeasure
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Long Transactions Support
      %w{
        AddAuth
        CheckAuth
        DisableLongTransactions
        EnableLongTransactions
        LockRow
        UnlockRows
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Miscellaneous Functions
      %w{
        ST_Accum
        Box2D
        Box3D
        ST_Estimated_Extent
        ST_Expand
        ST_Extent
        ST_3DExtent
        Find_SRID
        ST_Mem_Size
        ST_Point_Inside_Circle
      }.each do |name|
        const_set(name, Class.new(Function))
      end

      # Exceptional Functions
      %w{
        PostGIS_AddBBox
        PostGIS_DropBBox
        PostGIS_HasBBox
      }.each do |name|
        const_set(name, Class.new(Function))
      end

    end
  end
end
