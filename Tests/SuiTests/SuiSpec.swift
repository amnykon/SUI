import Quick
import Nimble
@testable import Sui
import Foundation
import LimitOperator

class MockModelWidget<T:Any> : ModelWidget<T> {
  override init(of model:Model<T>) {
    super.init(of:model)
  }
  var hasUpdated=false
  override func update() {
    hasUpdated=true
  }
}

class SuiSpec: QuickSpec {
  override func spec() {

    describe("Widget") {
      let test:StyleProperty<Int> = StyleProperty(23)

      let widgetType=WidgetType(parent:anyWidgetType)
      let parentType=WidgetType(parent:anyWidgetType)
      let grandParentType=WidgetType(parent:anyWidgetType)

      var widget=Widget(type:anyWidgetType)
      var parent=Widget(type:anyWidgetType)
      var grandParent=Widget(type:anyWidgetType)

      beforeEach {
        grandParent=Widget(type:grandParentType)
        parent=Widget(type:parentType)
        parent.container=grandParent
        widget=Widget(type:widgetType)
        widget.container=parent
      }

      context("with style") {
        beforeEach {
          widget.style=Style(properties:StyleProperties(StylePropertyValue(test, 12)))
        }
        it("can get property"){
          expect{widget.get(property:test)}.to(equal(12))
        }
        it("can change styles"){
          expect{widget.get(property:test)}.to(equal(12))
          widget.style=Style(properties:StyleProperties(StylePropertyValue(test, 13)))
          expect{widget.get(property:test)}.to(equal(13))
        }
      }
      it("can change styles when parent changes style"){
        expect{widget.get(property:test)}.to(equal(23))
        parent.style=Style(properties:StyleProperties(StylePropertyValue(test, 13)))
        expect{widget.get(property:test)}.to(equal(13))
      }
      it("can change styles when moved to a new parent"){
        parent.style=Style(properties:StyleProperties(StylePropertyValue(test, 13)))
        grandParent.style=Style(properties:StyleProperties(StylePropertyValue(test, 14)))
        expect{widget.get(property:test)}.to(equal(13))
        widget.container=grandParent
        expect{widget.get(property:test)}.to(equal(14))
      }
    }

    describe("style") {

      let property:StyleProperty = StyleProperty("default value")
      let otherStyleProperty:StyleProperty = StyleProperty("other property")

      let widgetType=WidgetType(parent:anyWidgetType)
      let parentType=WidgetType(parent:anyWidgetType)
      let grandParentType=WidgetType(parent:anyWidgetType)
      let otherWidgetType=WidgetType(parent:anyWidgetType)

      var widget=Widget(type:anyWidgetType)
      var parent=Widget(type:anyWidgetType)
      var grandParent=Widget(type:anyWidgetType)

      beforeEach {
        grandParent=Widget(type:grandParentType)
        parent=Widget(type:parentType)
        parent.container=grandParent
        widget=Widget(type:widgetType)
        widget.container=parent
      }
      it("gets properties matching self"){
        let value="set"
        widget.style=Style(properties:StyleProperties(StylePropertyValue(property,value)))
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->parent->widget"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->parent->widget"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching parent->widget"){
        let value="set"
        widget.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->any->widget"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->any->widget"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->widget"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->widget"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching widget"){
        let value="set"
        widget.style=Style(
          children:[
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->parent->any"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->parent->any"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching parent->any"){
        let value="set"
        widget.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->any->any"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->any->any"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->any"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->any"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching anyWidgetType"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,value)))
            ]
          )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent->parent"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching any->parent"){
        let value="set"
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching parent"){
        let value="set"
        widget.style=Style(
          children:[
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties matching grandParent"){
        let value="set"
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }

      it("gets properties of parent matching self"){
        let value="set"
        parent.style=Style(
          properties:StyleProperties(StylePropertyValue(property,value))
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->parent->widget"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->parent->widget"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching parent->widget"){
        let value="set"
        parent.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->any->widget"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->any->widget"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->widget"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->widget"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching widget"){
        let value="set"
        parent.style=Style(
          children:[
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->parent->any"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->parent->any"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching parent->any"){
        let value="set"
        parent.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->any->any"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->any->any"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->any"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->any"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching anyWidgetType"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent->parent"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching any->parent"){
        let value="set"
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching parent"){
        let value="set"
        parent.style=Style(
          children:[
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching grandParent"){
        let value="set"
        parent.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of parent matching self"){
        let value="set"
        parent.style=Style(
          properties:StyleProperties(StylePropertyValue(property,value))
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->parent->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->parent->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching parent->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->any->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->any->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching widget"){
        let value="set"
        grandParent.style=Style(
          children:[
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->parent->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->parent->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching parent->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->any->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->any->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,value))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->any"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching anyWidgetType"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent->parent"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching any->parent"){
        let value="set"
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,value))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching parent"){
        let value="set"
        grandParent.style=Style(
          children:[
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("gets properties of grandParent matching grandParent"){
        let value="set"
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,value))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal(value))
      }
      it("does not get properties when no style is set"){
        expect{widget.get(property:property)}.to(equal(property.defaultValue))
      }
      it("does not get properties when type does not match"){
        let style=Style(
          children: [
            otherWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"self"))
            ),
            widgetType:Style(
              children: [
                otherWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children: [
                otherWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any"))
                ),
                anyWidgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any"))
                    ),
                  ]
                ),
                widgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                    ),
                  ]
                ),
              ]
            ),
            parentType:Style(
              children: [
                otherWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent"))
                ),
                anyWidgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                    ),
                  ]
                ),
                widgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                    ),
                  ]
                ),
              ]
            ),
          ]
        )
        widget.style=style
        parent.style=style
        grandParent.style=style
        expect{widget.get(property:property)}.to(equal(property.defaultValue))
      }
      it("does not get properties when property does not match"){
        let style=Style(
          properties:StyleProperties(
            StylePropertyValue(otherStyleProperty,"self")
          ),
          children:[
            widgetType:Style(
              properties:StyleProperties(
                StylePropertyValue(otherStyleProperty,"widget")
              )
            ),
            parentType:Style(
              properties:StyleProperties(
                StylePropertyValue(otherStyleProperty,"parent")
              ),
              children:[
                widgetType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"parent->widget")
                  )
                ),
                anyWidgetType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"parent->any")
                  )
                )
              ]
            ),
            grandParentType:Style(
              properties:StyleProperties(
                StylePropertyValue(otherStyleProperty,"grandParent")
              ),
              children:[
                widgetType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"grandParent->widget")
                  )
                ),
                anyWidgetType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"grandParent->any")
                  ),
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"grandParent->any->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"grandParent->any->any")
                      )
                    )
                  ]
                ),
                parentType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"grandParent->parent")
                  ),
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"grandParent->parent->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"grandParent->parent->any")
                      )
                    )
                  ]
                )
              ]
            ),
            anyWidgetType:Style(
              properties:StyleProperties(
                StylePropertyValue(otherStyleProperty,"any")
              ),
              children:[
                widgetType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"any->widget")
                  )
                ),
                anyWidgetType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"any->any")
                  ),
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"any->any->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"any->any->any")
                      )
                    )
                  ]
                ),
                parentType:Style(
                  properties:StyleProperties(
                    StylePropertyValue(otherStyleProperty,"any->parent")
                  ),
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"any->parent->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:StyleProperties(
                        StylePropertyValue(otherStyleProperty,"any->parent->any")
                      )
                    )
                  ]
                )
              ]
            )
          ]
        )
        widget.style=style
        parent.style=style
        grandParent.style=style
        expect{widget.get(property:property)}.to(equal(property.defaultValue))
      }
      it("gets properties matching self over grandParent->parent->widget"){
        widget.style=Style(
          properties:StyleProperties(StylePropertyValue(property,"self")),
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("self"))
      }
      it("gets properties matching grandParent->parent->widget over any->parent->widget"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties matching any->parent->widget over parent->widget"){
        widget.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties matching parent->widget over grandParent->any->widget"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->widget"))
      }
      it("gets properties matching grandParent->any->widget over any->any->widget"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->widget"))
      }

      it("gets properties matching any->any->widget over any->widget"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                ),
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->widget"))
      }
      it("gets properties matching any->widget over grandParent->widget"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->widget"))
      }
      it("gets properties matching grandParent->widget over widget"){
        widget.style=Style(
          children:[
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"widget"))
            ),
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->widget"))
      }
      it("gets properties matching widget over grandParent->parent->any"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            ),
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"widget"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("widget"))
      }
      it("gets properties matching grandParent->parent->any over any->parent->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->any"))
      }
      it("gets properties matching any->parent->any over parent->any"){
        widget.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent->any"))
      }
      it("gets properties matching parent->any over grandParent->any->any"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->any"))
      }
      it("gets properties matching grandParent->any->any over any->any->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->any"))
      }
      it("gets properties matching any->any->any over any->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->any")),
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->any"))
      }
      it("gets properties matching any->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any"))
      }
      it("gets properties matching grandParent->any over any"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"any")),
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any"))
      }
      it("gets properties matching anyWidgetType over grandParent->parent"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->parent"))
                )
              ]
            ),
            anyWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"any"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any"))
      }
      it("gets properties matching grandParent->parent over any->parent"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->parent"))
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent"))
      }
      it("gets properties matching any->parent over parent"){
        widget.style=Style(
          children:[
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"parent"))
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent"))
      }
      it("gets properties matching parent over grandParent"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"grandParent"))
            ),
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"parent"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent"))
      }

      it("gets properties of widget over properties of parent"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"grandParent"))
            ),
          ]
        )
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent"))
      }
      it("gets properties of parent matching grandParent->parent->widget over any->parent->widget"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of parent matching any->parent->widget over parent->widget"){
        parent.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of parent matching parent->widget over grandParent->any->widget"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->widget"))
      }
      it("gets properties of parent matching grandParent->any->widget over any->any->widget"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->widget"))
      }

      it("gets properties of parent matching any->any->widget over any->widget"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                ),
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->widget"))
      }
      it("gets properties of parent matching any->widget over grandParent->widget"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->widget"))
      }
      it("gets properties of parent matching grandParent->widget over widget"){
        parent.style=Style(
          children:[
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"widget"))
            ),
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->widget"))
      }
      it("gets properties of parent matching widget over grandParent->parent->any"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            ),
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"widget"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("widget"))
      }
      it("gets properties of parent matching grandParent->parent->any over any->parent->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->any"))
      }
      it("gets properties of parent matching any->parent->any over parent->any"){
        parent.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent->any"))
      }
      it("gets properties of parent matching parent->any over grandParent->any->any"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->any"))
      }
      it("gets properties of parent matching grandParent->any->any over any->any->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->any"))
      }
      it("gets properties of parent matching any->any->any over any->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->any")),
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->any"))
      }
      it("gets properties of parent matching any->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any"))
      }
      it("gets properties of parent matching grandParent->any over any"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"any")),
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any"))
      }
      it("gets properties of parent matching anyWidgetType over grandParent->parent"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->parent"))
                )
              ]
            ),
            anyWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"any"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any"))
      }
      it("gets properties of parent matching grandParent->parent over any->parent"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->parent"))
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent"))
      }
      it("gets properties of parent matching any->parent over parent"){
        parent.style=Style(
          children:[
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"parent"))
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent"))
      }
      it("gets properties of parent matching parent over grandParent"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"grandParent"))
            ),
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"parent"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent"))
      }
      it("gets properties of parent matching grandParent over self"){
        parent.style=Style(
          properties:StyleProperties(StylePropertyValue(property,"self")),
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"grandParent"))
            ),
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent"))
      }
      it("gets properties of parent over properties of grandParent"){
        parent.style=Style(
          properties:StyleProperties(StylePropertyValue(property,"self"))
        )
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"self"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("self"))
      }
      it("gets properties of grandParent matching grandParent->parent->widget over any->parent->widget"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of grandParent matching any->parent->widget over parent->widget"){
        grandParent.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of grandParent matching parent->widget over grandParent->any->widget"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->widget"))
      }
      it("gets properties of grandParent matching grandParent->any->widget over any->any->widget"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->widget"))
      }

      it("gets properties of grandParent matching any->any->widget over any->widget"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                ),
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->widget"))
      }
      it("gets properties of grandParent matching any->widget over grandParent->widget"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->widget"))
      }
      it("gets properties of grandParent matching grandParent->widget over widget"){
        grandParent.style=Style(
          children:[
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"widget"))
            ),
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->widget"))
      }
      it("gets properties of grandParent matching widget over grandParent->parent->any"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            ),
            widgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"widget"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("widget"))
      }
      it("gets properties of grandParent matching grandParent->parent->any over any->parent->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->any"))
      }
      it("gets properties of grandParent matching any->parent->any over parent->any"){
        grandParent.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent->any"))
      }
      it("gets properties of grandParent matching parent->any over grandParent->any->any"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"parent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->any"))
      }
      it("gets properties of grandParent matching grandParent->any->any over any->any->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->any"))
      }
      it("gets properties of grandParent matching any->any->any over any->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->any")),
                  children:[
                    anyWidgetType:Style(
                      properties:StyleProperties(StylePropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->any"))
      }
      it("gets properties of grandParent matching any->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any"))
      }
      it("gets properties of grandParent matching grandParent->any over any"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"any")),
              children:[
                widgetType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any"))
      }
      it("gets properties of grandParent matching anyWidgetType over grandParent->parent"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->parent"))
                )
              ]
            ),
            anyWidgetType:Style(
              properties:StyleProperties(StylePropertyValue(property,"any"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any"))
      }
      it("gets properties of grandParent matching grandParent->parent over any->parent"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->parent"))
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"grandParent->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent"))
      }
      it("gets properties of grandParent matching any->parent over parent"){
        grandParent.style=Style(
          children:[
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"parent"))
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:StyleProperties(StylePropertyValue(property,"any->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent"))
      }
      it("gets properties of grandParent matching parent over grandParent"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"grandParent"))
            ),
            parentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"parent"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent"))
      }
      it("gets properties of grandPrarent matching grandParent over self"){
        grandParent.style=Style(
          properties:StyleProperties(StylePropertyValue(property,"self")),
          children:[
            grandParentType:Style(
              properties:StyleProperties(StylePropertyValue(property,"grandParent"))
            ),
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent"))
      }

    }

    describe("StyleProperties") {
      let test:StyleProperty<Int> = StyleProperty(23)
      let testInt1:StyleProperty<Int> = StyleProperty(12)
      let testInt2:StyleProperty<Int> = StyleProperty(15)
      let testString:StyleProperty<String> = StyleProperty("This is a test")
      let testTouple:StyleProperty = StyleProperty((12,13,14,15,16,17))

      var properties=StyleProperties()
      beforeEach {
        properties=StyleProperties()
      }
      it("will return nil when retrieving an unset property"){
        expect{properties.get(property:test)}.to(beNil())
      }
      it("will store and retrieve a property."){
        properties.set(property:test,to:12)
        expect{properties.get(property:test)}.to(equal(12))
      }
      it("will store and retrieve different types of properties."){
        properties.set(property:testInt1,to:12)
        properties.set(property:testString,to:"This is a test")
        properties.set(property:testTouple,to:(12,13,14,15,16,17))
        properties.set(property:testInt2,to:15)
        expect{properties.get(property:testInt1)}.to(equal(12))
        expect{properties.get(property:testString)}.to(equal("This is a test"))
        expect{properties.get(property:testTouple)?.0}.to(equal(12))
        expect{properties.get(property:testTouple)?.1}.to(equal(13))
        expect{properties.get(property:testTouple)?.2}.to(equal(14))
        expect{properties.get(property:testTouple)?.3}.to(equal(15))
        expect{properties.get(property:testTouple)?.4}.to(equal(16))
        expect{properties.get(property:testTouple)?.5}.to(equal(17))
        expect{properties.get(property:testInt2)}.to(equal(15))
      }
      it("can be initallized with values") {
        properties=StyleProperties(
          StylePropertyValue(testInt1,12),
          StylePropertyValue(testString,"This is a test"),
          StylePropertyValue(testTouple,(12,13,14,15,16,17)),
          StylePropertyValue(testInt2,15)
        )
        expect{properties.get(property:testInt1)}.to(equal(12))
        expect{properties.get(property:testString)}.to(equal("This is a test"))
        expect{properties.get(property:testTouple)?.0}.to(equal(12))
        expect{properties.get(property:testTouple)?.1}.to(equal(13))
        expect{properties.get(property:testTouple)?.2}.to(equal(14))
        expect{properties.get(property:testTouple)?.3}.to(equal(15))
        expect{properties.get(property:testTouple)?.4}.to(equal(16))
        expect{properties.get(property:testTouple)?.5}.to(equal(17))
        expect{properties.get(property:testInt2)}.to(equal(15))

      }
    }

    describe("Type") {
      let parent=WidgetType(parent:anyWidgetType)
      let child=WidgetType(parent:parent)

      it("will compare") {
        expect{child == child}.to(equal(true))
        expect{child == parent}.to(equal(false))
        expect{parent == child}.to(equal(false))
        expect{parent == parent}.to(equal(true))
      }

      it("will hash") {
        expect{child.hashValue == child.hashValue}.to(equal(true))
        expect{parent.hashValue == parent.hashValue}.to(equal(true))
        expect{anyWidgetType.hashValue == anyWidgetType.hashValue}.to(equal(true))
      }

      it("can be used as a key for a dictionary") {
        let dic=[
          child:"child",
          parent:"parent",
          anyWidgetType:"anyWidgetType"
        ]
        expect{dic[child]}.to(equal("child"))
        expect{dic[parent]}.to(equal("parent"))
        expect{dic[anyWidgetType]}.to(equal("anyWidgetType"))
      }

      it("will identify parents") {
        expect{child.isChild(of:parent)}.to(equal(true))
        expect{child.isChild(of:anyWidgetType)}.to(equal(true))
        expect{parent.isChild(of:anyWidgetType)}.to(equal(true))
        expect{parent.isChild(of:child)}.to(equal(false))
      }
    }

    describe("Model") {
      it("can create a View") {
        let modelInt=Model(of:0)
        let view=modelInt.createView()
        expect{view.model}.to(beIdenticalTo(modelInt))
      }
      it("can create a Control") {
        let modelInt=Model(of:0)
        let control=modelInt.createControl()
        expect{control.model}.to(beIdenticalTo(modelInt))
      }
      it("will update MockModelWidget if value is changed.") {
        let modelInt=Model(of:0)
        let modelWidget=MockModelWidget(of:modelInt)
        modelInt.value=2
        expect{modelWidget.hasUpdated}.to(equal(true))
      }
      it("will change value (and not crash) after a Control has been deinit.") {
        let modelInt=Model(of:0)
        do {
          _=MockModelWidget(of:modelInt)
        }
        modelInt.value=2
      }
    }

    describe("ModelWidget") {
      it("can get different genericWidgetTypes") {
        expect{ModelWidget<Int>.genericWidgetType}.to(equal(ModelWidget<Int>.genericWidgetType))
        expect{ModelWidget<String>.genericWidgetType}.to(equal(ModelWidget<String>.genericWidgetType))
        expect{ModelWidget<[Int]>.genericWidgetType}.to(equal(ModelWidget<[Int]>.genericWidgetType))

        expect{ModelWidget<Int>.genericWidgetType}.notTo(equal(ModelWidget<String>.genericWidgetType))
        expect{ModelWidget<Int>.genericWidgetType}.notTo(equal(ModelWidget<[Int]>.genericWidgetType))
        expect{ModelWidget<String>.genericWidgetType}.notTo(equal(ModelWidget<[Int]>.genericWidgetType))
      }
    }

    describe("View") {
      it("has the same genericWidgetTypes as ModelWidget") {
        expect{View<Int>.genericWidgetType}.to(equal(ModelWidget<Int>.genericWidgetType))
        expect{View<String>.genericWidgetType}.to(equal(ModelWidget<String>.genericWidgetType))
        expect{View<[Int]>.genericWidgetType}.to(equal(ModelWidget<[Int]>.genericWidgetType))
      }
      it("'s viewWidgetTypes are different then genericWidgetTypes") {
        expect{View<Int>.viewWidgetType}.notTo(equal(View<Int>.genericWidgetType))
        expect{View<String>.viewWidgetType}.notTo(equal(View<String>.genericWidgetType))
        expect{View<[Int]>.viewWidgetType}.notTo(equal(View<[Int]>.genericWidgetType))
      }
      it("can get different viewWidgetTypes") {
        expect{View<Int>.viewWidgetType}.to(equal(View<Int>.viewWidgetType))
        expect{View<String>.viewWidgetType}.to(equal(View<String>.viewWidgetType))
        expect{View<[Int]>.viewWidgetType}.to(equal(View<[Int]>.viewWidgetType))

        expect{View<Int>.viewWidgetType}.notTo(equal(View<String>.viewWidgetType))
        expect{View<Int>.viewWidgetType}.notTo(equal(View<[Int]>.viewWidgetType))
        expect{View<String>.viewWidgetType}.notTo(equal(View<[Int]>.viewWidgetType))
      }
    }

    describe("Control") {
      it("has the same genericWidgetTypes as ModelWidget") {
        expect{Control<Int>.genericWidgetType}.to(equal(ModelWidget<Int>.genericWidgetType))
        expect{Control<String>.genericWidgetType}.to(equal(ModelWidget<String>.genericWidgetType))
        expect{Control<[Int]>.genericWidgetType}.to(equal(ModelWidget<[Int]>.genericWidgetType))
      }
      it("'s ControlWidgetTypes are different then genericWidgetTypes") {
        expect{Control<Int>.controlWidgetType}.notTo(equal(Control<Int>.genericWidgetType))
        expect{Control<String>.controlWidgetType}.notTo(equal(Control<String>.genericWidgetType))
        expect{Control<[Int]>.controlWidgetType}.notTo(equal(Control<[Int]>.genericWidgetType))
      }
      it("can get different ControlWidgetTypes") {
        expect{Control<Int>.controlWidgetType}.to(equal(Control<Int>.controlWidgetType))
        expect{Control<String>.controlWidgetType}.to(equal(Control<String>.controlWidgetType))
        expect{Control<[Int]>.controlWidgetType}.to(equal(Control<[Int]>.controlWidgetType))

        expect{Control<Int>.controlWidgetType}.notTo(equal(Control<String>.controlWidgetType))
        expect{Control<Int>.controlWidgetType}.notTo(equal(Control<[Int]>.controlWidgetType))
        expect{Control<String>.controlWidgetType}.notTo(equal(Control<[Int]>.controlWidgetType))
      }
    }

    describe("Point") {
      it("can check for equality") {
        expect{Point(2,3)==Point(2,3)}.to(equal(true))
        expect{Point(3,3)==Point(2,3)}.to(equal(false))
        expect{Point(2,4)==Point(2,3)}.to(equal(false))
      }
      it("can add to another Point") {
        expect{Point(2,3)+Point(7,4)}.to(equal(Point(9,7)))
      }
      it("can limit add to another Point") {
        expect{Point(Int32.max,3)^+Point(7,4)}.to(equal(Point(Int32.max,7)))
        expect{Point(3,Int32.max)^+Point(7,4)}.to(equal(Point(10,Int32.max)))
      }
      it("can subtract from another Point") {
        expect{Point(9,7)-Point(2,3)}.to(equal(Point(7,4)))
      }
      it("can be devided by an int") {
        expect{Point(4,6)/2}.to(equal(Point(2,3)))
        expect{Point(5,6)/2}.to(equal(Point(2,3)))
      }
      it("can be divided by another Point") {
        expect{Point(2,6)/Point(2,3)}.to(equal(Point(1,2)))
      }
      it("can be multiplied by another Point") {
        expect{Point(2,6)*Point(2,3)}.to(equal(Point(4,18)))
      }
      it("can get the max value for each dimension") {
        expect{max(Point(2,6),Point(4,3))}.to(equal(Point(4,6)))
      }
      it("can get the min value for each dimension") {
        expect{min(Point(2,6),Point(4,3))}.to(equal(Point(2,3)))
      }
    }

    describe("RequestedSize") {
      it("can check for equality") {
        expect{RequestedSize(Point(7,1),Point(8,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(true))
        expect{RequestedSize(Point(8,1),Point(8,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
        expect{RequestedSize(Point(7,2),Point(8,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
        expect{RequestedSize(Point(7,1),Point(9,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
        expect{RequestedSize(Point(7,1),Point(8,3))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
      }
    }

    describe("AllocatedSpace") {
      it("can check for equality") {
        expect{AllocatedSpace(Point(7,1),Point(8,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(true))
        expect{AllocatedSpace(Point(8,1),Point(8,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
        expect{AllocatedSpace(Point(7,2),Point(8,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
        expect{AllocatedSpace(Point(7,1),Point(9,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
        expect{AllocatedSpace(Point(7,1),Point(8,3))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
      }
    }

    describe("LayoutProperty") {
      it("'s default behavior is VerticalLayout") {
        let widgetType=WidgetType(parent:anyWidgetType)
        let widget=Widget(type:widgetType)
        expect{String(describing:type(of:widget.get(property:layoutProperty)))}
          .to(equal(String(describing:VerticalLayout.self)))
      }
   }

    describe("FixedLayout") {
      it("will getRequestedSize") {
        let widgetType=WidgetType(parent:anyWidgetType)
        let widget=Widget(type:widgetType)
        widget.style=Style(
          properties:StyleProperties(
            StylePropertyValue(
              layoutProperty,
              FixedLayout(min:Point(1,2), max:Point(3,4))
            )
          )
        )
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(1,2),Point(3,4))))
      }
    }

    describe("VerticalLayout") {
      let widgetType=WidgetType(parent:anyWidgetType)
      var widget=Widget(type:widgetType)
      var child1=Widget(type:widgetType)
      var child2=Widget(type:widgetType)
      beforeEach{
        widget=Widget(type:widgetType)
        child1=Widget(type:widgetType)
        child2=Widget(type:widgetType)
        child1.container=widget
        child2.container=widget

        widget.style=Style(
          properties:StyleProperties(StylePropertyValue(layoutProperty, VerticalLayout())),
          children:[
            widgetType:Style(
              properties:StyleProperties(
                StylePropertyValue(
                  layoutProperty,
                  FixedLayout(min:Point(1,2), max:Point(3,4))
                )
              )
            )
          ]
        )
      }
      it("will getRequestedSize") {
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(1,4),Point(3,8))))
      }
      it("will allocateSpace for contents") {
        expect(child1.allocatedSpace).to(equal(AllocatedSpace(Point(0,0), Point(1,2))))
        expect(child2.allocatedSpace).to(equal(AllocatedSpace(Point(0,2), Point(1,2))))
      }
    }

    describe("Widget") {
      context("will clear cashe") {
        var widgetType=WidgetType(parent:anyWidgetType)
        var widget=MockWidget(type:widgetType)
        beforeEach{
          widgetType=WidgetType(parent:anyWidgetType)
          widget=MockWidget(type:widgetType)
        }
        context("of style") {
          afterEach{
            expect(widget.cashedStyleCleared).to(equal(true))
          }
          it("when wiget is moved to a container") {
            let parent=MockWidget(type:widgetType)
            widget.container=parent
          }
          it("when style is changed") {
            widget.style=Style()
          }
          it("when container's styleCashe is cleared") {
            let container=MockWidget(type:widgetType)
            widget.container=container
            widget.cashedStyleCleared=false
            container.clearStyleCashe()
          }
        }
        context("of RequestSize") {
          var widgetType=WidgetType(parent:anyWidgetType)
          var widget=MockWidget(type:widgetType)
          beforeEach{
            widgetType=WidgetType(parent:anyWidgetType)
            widget=MockWidget(type:widgetType)
          }
          afterEach{
            expect(widget.cashedRequestedSizeCleared).to(equal(true))
          }
          it("when styleCase is cleared") {
            widget.clearStyleCashe()
          }
          it("contents have been added") {
            let contained=MockWidget(type:widgetType)
            contained.container=widget
          }
          it("when contents have been removed") {
            let contained=MockWidget(type:widgetType)
            contained.container=widget
            widget.cashedRequestedSizeCleared=false
            contained.container=nil
          }
          it("when a contained's RequestSize has been cleared") {
            let contained=MockWidget(type:widgetType)
            contained.container=widget
            widget.cashedRequestedSizeCleared=false
            contained.clearRequestedSizeCashe()
          }
        }
        context("of AllocatedSpace") {
          var widgetType=WidgetType(parent:anyWidgetType)
          var widget=MockWidget(type:widgetType)
          beforeEach{
            widgetType=WidgetType(parent:anyWidgetType)
            widget=MockWidget(type:widgetType)
          }
          afterEach{
            expect(widget.cashedAllocatedSpaceCleared).to(equal(true))
          }
          it("when requestedSize has been cleared") {
            widget.clearRequestedSizeCashe()
          }
          it("when container's allocatedSpace has been cleared") {
            let container=MockWidget(type:widgetType)
            widget.container=container
            widget.cashedAllocatedSpaceCleared=false
            container.clearAllocatedSpaceCashe()
          }
        }
      }
    }
  }
}

