<div class="section" about="#" typeof="owl:Ontology bibo:Webpage">

## Loupe: A Second-Generation RDF Display Vocabulary

  - Author  
    [<span property="foaf:name">Dorian
    Taylor</span>](http://doriantaylor.com/person/dorian-taylor#me)
  - Created  
    January 14, 2020
  - Updated  
    August 11, 2020
  - Namespace URI  
    <https://vocab.methodandstructure.com/loupe#>
  - Preferred Namespace Prefix  
    loupe

This document specifies a candidate successor to the Fresnel vocabulary,
that takes into account developments in RDFa, JSON-LD, SPARQL 1.1 and
SHACL. In keeping with the theme of French names involving lenses, this
candidate is called <span class="dfn">Loupe</span>, which is a kind of
(and indeed the generic French word for) magnifiying glass.

<div class="section">

### History & Rationale

In 2004, a group of researchers devised [the Fresnel display
vocabulary](https://www.w3.org/2005/04/fresnel-info/). It remained
largely in academic circles and was not widely implemented. In the
intervening decade and a half, moreover, there have been multiple
advancements in the display (RDFa, JSON-LD) and selection (SPARQL 1.1,
SHACL) of RDF graphs. This vocabulary is an attempt to revisit the
problem while taking these developments into account.

The fundamental problem of displaying RDF is that a *document*, at least
for our purposes, is an *ordered tree* of content, whereas RDF has no
orientation to speak of, leaving many questions about how to display it
unanswered. In order to render an RDF subject as a document, we need a
number of instructions for computing a definite sequence of properties
*and* their values, which properties and values to show and which to
hide, and recursively descending (along with directives on when to hit
the brakes), and at least roughly, *how* everything ought to be
formatted.

The goal of Loupe, like Fresnel, is to define a language for specifying
the parameters of a node-centric display of an RDF graph, and generating
an abstract document tree which can be made more concrete in formats
like (X)HTML+RDFa or JSON-LD. One requirement of Loupe is that the
abstract document tree preserves the embedded graph structure, enabling
said structure to be transmitted to final concrete data format intact.
Loupe carries forward the lens/format design of Fresnel, and reuses as
much of SHACL as is reasonable to do.

</div>

<div class="section">

### Matching Nodes & Enumerating Properties

Both Fresnel and Loupe begin with the assumption that what you *have* is
a set of RDF statements radiating off a given subject, and what you
*want* are clear, consistent, and unambiguous instructions for how to
render those statements as a document.

Fresnel has entities called <span class="dfn">Lenses</span> that get
selected through their binding to an RDF class or instance URI. Lenses
say which properties to show and in what order. Fresnel also has
<span class="dfn">property descriptions</span> that attach additional
behaviour to property selections. This functionality can be readily
handled by SHACL node and property shapes, with only minor extensions.

  - okay what do we know about shapes
  - shacl has node shapes and it has property shapes
  - the node shapes select target nodes and encapsulate a set of
    property shapes
  - note that property shapes do not correspond 1:1 to properties
  - property shapes define paths and constraints, mainly for shape
    validation
  - we will appropriate these for use instead as selectors (ie don't
    display the property's value if the shape's constraints fail to
    validate)

<!-- end list -->

    @prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
    @prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> .
    @prefix owl:   <http://www.w3.org/2002/07/owl#> .
    @prefix xsd:   <http://www.w3.org/2001/XMLSchema#> .
    @prefix sh:    <http://www.w3.org/ns/shacl#> .
    
    @prefix loupe: <https://vocab.methodandstructure.com/loupe#> .
    @prefix foaf:  <http://xmlns.com/foaf/0.1/> .
    
    ex:person a loupe:Lens;
      sh:targetClass foaf:Person ;
      #
      loupe:show ( ex:name ex:avatar ex:email ) ;
      sh:property ex:name, ex:avatar, ex:email .
    
    ex:given-name a sh:PropertyShape ;
      sh:path [ sh:alternativePath (
        foaf:givenName foaf:firstName foaf:givenname ) ] .
    
    ex:family-name a sh:PropertyShape ;
      sh:path [ sh:alternativePath (
        foaf:familyName foaf:lastName foaf:family_name foaf:surname ) ] .
    
    ex:name a loupe:IDUNNO ;
      sh:path [ sh:alternativePath (
        foaf:name [ loupe:merge ( ex:given-name ex:family-name ) ] ) ] .

<div id="Lens" class="section" about="[loupe:Lens]" typeof="owl:Class">

#### Lens

The basic element of Loupe, a specific kind of SHACL node shape.

  - Subclass of:  
    [sh:NodeShape](https://www.w3.org/TR/shacl/#node-shapes)

[Back to Top](https://vocab.methodandstructure.com/loupe#)

</div>

</div>

<div class="section">

### Sorting Properties & Values

in the absence of a specific enumeration,

</div>

<div class="section">

### Label & Description Shapes

When a node is the subject of the resulting document or section thereof,
or the target of a link, it will almost always need a label. Exactly one
label needs to be definitively and consistently chosen from a set of
literal values associated with a set of properties (or rather, property
paths).

</div>

</div>

<div class="section">

## References

  - [Fresnel](https://www.w3.org/2005/04/fresnel-info/)
  - [SHACL](https://www.w3.org/TR/shacl/)
  - [SPARQL 1.1 Query Language](https://www.w3.org/TR/sparql11-query/)
  - [RDFa Core](https://www.w3.org/TR/rdfa-core/) and [HTML
    embedding](https://www.w3.org/TR/rdfa-in-html/)
  - [JSON-LD 1.1](https://www.w3.org/TR/json-ld/)

</div>
