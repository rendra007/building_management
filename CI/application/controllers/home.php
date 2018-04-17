<?php

/**
 *
 */
class Home extends CI_Controller
{

  function index()
  {
    $this->load->model('core/home_model');
    //$data['records']=$this->home_model->getAll();
    $data['records']=$this->home_model->getProcedureCall();

    $this->load->view('test/home_view',$data);$data['records']=$this->home_model->getAll();
  }
}

 ?>
