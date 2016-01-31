// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IAHPhoto.h instead.

@import CoreData;

extern const struct IAHPhotoAttributes {
	__unsafe_unretained NSString *imageData;
} IAHPhotoAttributes;

extern const struct IAHPhotoRelationships {
	__unsafe_unretained NSString *notes;
} IAHPhotoRelationships;

@class IAHNote;

@interface IAHPhotoID : NSManagedObjectID {}
@end

@interface _IAHPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) IAHPhotoID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _IAHPhoto (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(IAHNote*)value_;
- (void)removeNotesObject:(IAHNote*)value_;

@end

@interface _IAHPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
