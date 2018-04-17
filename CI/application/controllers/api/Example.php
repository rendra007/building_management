<?php
if (!defined('BASEPATH')) exit('No direct script access allowed');

//include Rest Controller library
require APPPATH . '/libraries/REST_Controller.php';

class Example extends REST_Controller {

    public function __construct() {
        parent::__construct();

        //load user model
        //$this->load->model('core/home_model');
    }

    public function user_get($id = 0) {
        //returns all rows if the id parameter doesn't exist,
        //otherwise single row will be returned
        //$result = $this->home_model->getAll();
        $result='successfully hit get method';
        //check if the user data exists
        if(!empty($result)){
            //set the response and exit
            $this->response($result, REST_Controller::HTTP_OK);
        }else{
            //set the response and exit
            $this->response([
                'status' => FALSE,
                'message' => 'No user were found.'
            ], REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function user_post() {
      $this->response([
          'status' => FALSE,
          'message' => 'method is not implemented yet'
      ], REST_Controller::HTTP_NO_CONTENT);
    }

    public function user_put() {
      $this->response([
          'status' => FALSE,
          'message' => 'method is not implemented yet'
      ], REST_Controller::HTTP_NO_CONTENT);
    }

    public function user_delete($id){
      $this->response([
          'status' => FALSE,
          'message' => 'method is not implemented yet'
      ], REST_Controller::HTTP_NO_CONTENT);
    }
}

?>
