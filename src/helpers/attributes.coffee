import Classes from "#helpers/classes"
import Styles from "#helpers/styles"

Attributes =

  from: ( target ) ->
    name: target.byname
    style: Styles.from target
    class: Classes.from target


export default Attributes