include: "bsandell.view"

view: bsandell_extend {
  extends: [bsandell]

measure: total_number_of_pit_crew_members {
  type:  sum
  sql: ${number_of_pit_crew_members} ;;
}

}
