<?php

/**
 *
 */
class Home_model extends CI_Model
{

  function getAll()
  {
    $q = $this->db->get('tbl_menu');

    if($q->num_rows() > 0){
      foreach ($q->result() as $row) {
        $data[]=$row;
      }
      return $data;
    }
  }

  function getProcedureCall(){

    $inParameter = 'Test MySQL stored Procedure';
    $outParameter = '';
    $query = "call TestInOutProcedure(?,@outParameter);";
    $params = array($inParameter);
    $result = $this->db->query($query, $params);
    $sqlGetOutParam = "SELECT @outParameter;";
    $outValue = $this->db->query($sqlGetOutParam);
    return $outValue->result();

  }
}


 ?>
