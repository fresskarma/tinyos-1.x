// *** WARNING ****** WARNING ****** WARNING ****** WARNING ****** WARNING ***
// ***                                                                     ***
// *** This file was automatically generated by create_NeighborExt.pl.     ***
// *** Any and all changes made to this file WILL BE LOST!                 ***
// ***                                                                     ***
// *** WARNING ****** WARNING ****** WARNING ****** WARNING ****** WARNING ***


interface Neighbor_anchors
{
  command void set( uint16_t address, anchorArray_t* anchors );
  command void setElement( uint16_t address, anchor_t* anchors, uint8_t elementIndex );
  command void requestRemoteTuples();
  command void publish();
  command void publishElement(uint8_t elementIndex);
  event void updatedFromRemote( uint16_t address );
  command NeighborPtr_t getByAddress(uint16_t address);
  command TupleIterator_t initIterator();
  command bool getNext(TupleIterator_t* iterator);

}
